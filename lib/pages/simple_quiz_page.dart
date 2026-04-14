import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../services/persistence_service.dart';
import '../services/analytics_service.dart';
import '../services/auto_save_service.dart';
import '../services/undo_service.dart';
import '../models/user_progress.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/app_card.dart';
import '../widgets/app_option_button.dart';
import '../widgets/undo_button.dart';

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  final String question;
  final List<String> options;
  final int correctAnswerIndex;
}

String _formatScore(double score) {
  if (score % 1 == 0) {
    return score.toInt().toString();
  }
  return score.toStringAsFixed(2);
}

class SimpleQuizPage extends StatefulWidget {
  const SimpleQuizPage({
    super.key,
    required this.title,
    required this.questions,
    this.quizId, // Optional ID to save high scores
    this.subject, // NEW: Optional subject name for analytics
  });

  final String title;
  final List<QuizQuestion> questions;
  final String? quizId;
  final String? subject;

  @override
  State<SimpleQuizPage> createState() => _SimpleQuizPageState();
}

class _SimpleQuizPageState extends State<SimpleQuizPage> {
  static const int _questionTimeInSeconds = 30;
  static const double _correctMark = 1.0;
  static const double _wrongMark = 0.33;

  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  double _score = 0;
  int _timeLeft = _questionTimeInSeconds;
  Timer? _timer;
  late final List<QuizQuestion> _quizQuestions;
  late final List<int?> _selectedAnswers;
  
  // Performance stats
  late QuizStats _stats;

  @override
  void initState() {
    super.initState();
    _quizQuestions = _createShuffledQuestions(widget.questions);
    _selectedAnswers = List<int?>.filled(_quizQuestions.length, null);
    _loadStats();
    _restoreProgress(); // Restore auto-saved state
    _startTimer();
  }

  void _handleUndo(UndoAction action) {
    if (action.type == 'mcq' && action.metadata is int) {
      final int index = action.metadata;
      
      setState(() {
        // 1. Revert Score
        final int? oldAnswer = action.previousProgress?.selectedAnswerIndex;
        final int? currentAnswer = _selectedAnswers[index];
        
        // Remove current score contribution
        if (currentAnswer != null) {
          if (currentAnswer == _quizQuestions[index].correctAnswerIndex) {
            _score -= _correctMark;
          } else {
            _score += _wrongMark;
          }
        }
        
        // Add previous score contribution if any
        if (oldAnswer != null) {
          if (oldAnswer == _quizQuestions[index].correctAnswerIndex) {
            _score += _correctMark;
          } else {
            _score -= _wrongMark;
          }
        }

        // 2. Revert answer state
        _selectedAnswers[index] = oldAnswer;
        if (index == _currentQuestionIndex) {
          _selectedAnswerIndex = oldAnswer;
        }
      });
    } else if (action.type == 'bookmark') {
      PersistenceService().revertBookmark(
        action.id, 
        action.previousProgress?.isBookmarked
      );
    }
  }

  void _restoreProgress() {
    for (int i = 0; i < _quizQuestions.length; i++) {
      final String questionKey = '${widget.quizId ?? widget.title}_${_quizQuestions[i].question}';
      final savedProgress = AutoSaveService().getProgress(questionKey);
      if (savedProgress != null && savedProgress.isAttempted) {
        _selectedAnswers[i] = savedProgress.selectedAnswerIndex;
        // If it's the current question and we just restored it, we need to show the selection
        if (i == _currentQuestionIndex) {
          _selectedAnswerIndex = savedProgress.selectedAnswerIndex;
        }
      }
    }
  }
  
  void _loadStats() {
    if (widget.quizId != null) {
      _stats = PersistenceService().getQuizStats(widget.quizId!);
    } else {
      _stats = QuizStats(lastScore: 0, bestScore: 0, totalAttempts: 0);
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  QuizQuestion get _currentQuestion => _quizQuestions[_currentQuestionIndex];

  List<QuizQuestion> _createShuffledQuestions(List<QuizQuestion> questions) {
    final shuffledQuestions = List<QuizQuestion>.from(questions);

    if (shuffledQuestions.length <= 1) {
      return shuffledQuestions;
    }

    shuffledQuestions.shuffle(Random());

    if (_isSameOrder(shuffledQuestions, questions)) {
      final firstQuestion = shuffledQuestions.removeAt(0);
      shuffledQuestions.add(firstQuestion);
    }

    return shuffledQuestions;
  }

  bool _isSameOrder(List<QuizQuestion> first, List<QuizQuestion> second) {
    for (int index = 0; index < first.length; index++) {
      if (!identical(first[index], second[index])) {
        return false;
      }
    }

    return true;
  }

  void _selectAnswer(int index) {
    if (_selectedAnswerIndex != null) {
      return;
    }

    _stopTimer();

    setState(() {
      _selectedAnswerIndex = index;
      _selectedAnswers[_currentQuestionIndex] = index;

      final bool isCorrect = index == _currentQuestion.correctAnswerIndex;
      if (isCorrect) {
        _score += _correctMark;
      } else {
        _score -= _wrongMark;
      }

      // 1. PUSH TO UNDO HISTORY
      final String questionKey = '${widget.quizId ?? widget.title}_${_currentQuestion.question}';
      final previousState = AutoSaveService().getProgress(questionKey);
      UndoService().pushAction(UndoAction(
        id: questionKey,
        type: 'mcq',
        previousProgress: previousState,
        metadata: _currentQuestionIndex, // Store which question index to refresh on undo
      ));

      // 2. HIGH-PERFORMANCE AUTO-SAVE
      AutoSaveService().saveProgress(UserProgress(
        questionId: questionKey,
        selectedAnswerIndex: index,
        isAttempted: true,
      ));

      // 2. ANALYTICS
      AnalyticsService().recordQuestionResult(
        topic: widget.quizId ?? widget.title,
        isCorrect: isCorrect,
      );
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) {
        return;
      }

      _goToNextQuestion();
    });
  }

  void _goToNextQuestion() {
    _moveToNextQuestion(allowUnanswered: false);
  }

  void _startTimer() {
    _stopTimer();
    _timeLeft = _questionTimeInSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_timeLeft == 0) {
        timer.cancel();
        _moveToNextQuestion(allowUnanswered: true);
        return;
      }

      setState(() {
        _timeLeft--;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _moveToNextQuestion({required bool allowUnanswered}) {
    if (_selectedAnswerIndex == null) {
      if (!allowUnanswered) {
        return;
      }
    }

    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
      });
      _startTimer();
      return;
    }

    _stopTimer();

    // Calculate results for analytics
    int correctCount = 0;
    int wrongCount = 0;
    for (int i = 0; i < _quizQuestions.length; i++) {
      if (_selectedAnswers[i] == _quizQuestions[i].correctAnswerIndex) {
        correctCount++;
      } else if (_selectedAnswers[i] != null) {
        wrongCount++;
      }
    }
    
    // Save to global and subject analytics
    AnalyticsService().saveTestResult(widget.subject ?? 'General', correctCount, wrongCount);

    // Save score before showing result page
    if (widget.quizId != null) {
      PersistenceService().saveQuizScore(widget.quizId!, _score);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          title: widget.title,
          questions: _quizQuestions,
          selectedAnswers: List<int?>.from(_selectedAnswers),
          score: _score,
          quizId: widget.quizId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: widget.title,
      actions: [
        UndoButton(onUndo: _handleUndo),
      ],
      child: _buildQuestionView(context),
    );
  }

  Widget _buildQuestionView(BuildContext context) {
    final theme = Theme.of(context);
    final bool isAnswerSelected = _selectedAnswerIndex != null;
    final bool isCorrect = _selectedAnswerIndex == _currentQuestion.correctAnswerIndex;
    final int questionNumber = _currentQuestionIndex + 1;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.quizId != null) ...[
            AppCard(
              color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Last Score', '${_formatScore(_stats.lastScore)}/${_quizQuestions.length}', theme),
                  _buildStatItem('Best Score', '${_formatScore(_stats.bestScore)}/${_quizQuestions.length}', theme),
                  _buildStatItem('Attempts', '${_stats.totalAttempts}', theme),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          Row(
            children: [
              Expanded(
                child: AppCard(
                  color: theme.colorScheme.primaryContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Text('Question', style: theme.textTheme.labelSmall),
                      Text('$questionNumber/${_quizQuestions.length}', style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppCard(
                  color: theme.colorScheme.secondaryContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Text('Score', style: theme.textTheme.labelSmall),
                      Text(_formatScore(_score), style: theme.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          AppCard(
            color: _timeLeft <= 5 
                ? theme.colorScheme.errorContainer.withOpacity(0.8) 
                : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer_rounded, 
                  color: _timeLeft <= 5 ? theme.colorScheme.error : theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Time Left: $_timeLeft seconds', 
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: _timeLeft <= 5 ? theme.colorScheme.error : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _quizQuestions.length,
            minHeight: 8,
            borderRadius: BorderRadius.circular(12),
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
          
          const SizedBox(height: 24),
          
          AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer, 
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.help_outline_rounded, color: theme.colorScheme.primary, size: 28),
                ),
                const SizedBox(height: 20),
                Text(
                  _currentQuestion.question, 
                  textAlign: TextAlign.center, 
                  style: theme.textTheme.titleLarge?.copyWith(
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'Choose the correct answer', 
            textAlign: TextAlign.center, 
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          
          ...List.generate(_currentQuestion.options.length, (index) {
            return AppOptionButton(
              option: _currentQuestion.options[index],
              index: index,
              onTap: () => _selectAnswer(index),
              isSelected: _selectedAnswerIndex == index,
              isCorrect: index == _currentQuestion.correctAnswerIndex,
              isWrong: _selectedAnswerIndex == index && index != _currentQuestion.correctAnswerIndex,
              showResult: isAnswerSelected,
            );
          }),
          
          if (isAnswerSelected) ...[
            const SizedBox(height: 12),
            AppCard(
              color: isCorrect 
                  ? Colors.green.withOpacity(0.1) 
                  : theme.colorScheme.errorContainer.withOpacity(0.2),
              borderSide: BorderSide(
                color: isCorrect ? Colors.green : theme.colorScheme.error,
                width: 1,
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded, 
                    color: isCorrect ? Colors.green : theme.colorScheme.error,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      isCorrect 
                          ? 'Correct answer!' 
                          : 'Incorrect. Correct: ${_currentQuestion.options[_currentQuestion.correctAnswerIndex]}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isCorrect ? Colors.green.shade800 : theme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          value, 
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold, 
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label, 
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.title,
    required this.questions,
    required this.selectedAnswers,
    required this.score,
    this.quizId,
  });

  final String title;
  final List<QuizQuestion> questions;
  final List<int?> selectedAnswers;
  final double score;
  final String? quizId;

  @override
  Widget build(BuildContext context) {
    final int totalQuestions = questions.length;
    int correct = 0;
    int wrong = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i].correctAnswerIndex) {
        correct++;
      } else if (selectedAnswers[i] != null) {
        wrong++;
      }
    }

    final double percentage = (score / totalQuestions) * 100;
    final theme = Theme.of(context);

    String message;
    IconData resultIcon;
    if (percentage >= 80) {
      message = 'Excellent Performance 🎉';
      resultIcon = Icons.emoji_events_rounded;
    } else if (percentage >= 50) {
      message = 'Good Job 👍';
      resultIcon = Icons.military_tech;
    } else {
      message = 'Keep Practicing 💪';
      resultIcon = Icons.psychology_rounded;
    }

    return GpscPageScaffold(
      title: 'Quiz Result',
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withBlue(180).withRed(20),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Icon(
                      resultIcon,
                      size: 180,
                      color: Colors.white.withOpacity(0.12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            resultIcon,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.white24, indent: 40, endIndent: 40),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              _formatScore(score),
                              style: const TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '/$totalQuestions',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Percentage: ${percentage.toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          AppCard(
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryItem(
                  context,
                  'Total',
                  totalQuestions.toString(),
                  Icons.assignment_rounded,
                  theme.colorScheme.primary,
                ),
                _buildVerticalDivider(theme),
                _buildSummaryItem(
                  context,
                  'Correct',
                  correct.toString(),
                  Icons.check_circle_rounded,
                  Colors.green,
                ),
                _buildVerticalDivider(theme),
                _buildSummaryItem(
                  context,
                  'Wrong',
                  wrong.toString(),
                  Icons.cancel_rounded,
                  theme.colorScheme.error,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SimpleQuizPage(
                          title: title,
                          questions: questions,
                          quizId: quizId,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Exit'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Detailed Review',
              style: theme.textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 16),
          
          ...List.generate(questions.length, (index) {
            return _buildQuestionResultCard(
              context: context,
              questionNumber: index + 1,
              question: questions[index],
              selectedAnswerIndex: selectedAnswers[index],
            );
          }),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(ThemeData theme) {
    return Container(
      height: 40,
      width: 1,
      color: theme.colorScheme.outline.withOpacity(0.2),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionResultCard({
    required BuildContext context,
    required int questionNumber,
    required QuizQuestion question,
    required int? selectedAnswerIndex,
  }) {
    final theme = Theme.of(context);
    final bool isSkipped = selectedAnswerIndex == null;
    final bool isCorrect = selectedAnswerIndex == question.correctAnswerIndex;
    final String selectedAnswer = isSkipped
        ? 'Skipped'
        : question.options[selectedAnswerIndex];
    final String correctAnswer = question.options[question.correctAnswerIndex];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question $questionNumber',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                if (!isSkipped)
                  Icon(
                    isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                    color: isCorrect ? Colors.green : theme.colorScheme.error,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: theme.textTheme.titleMedium?.copyWith(
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            _buildAnswerBox(
              context: context,
              label: 'Your Answer',
              answer: selectedAnswer,
              icon: isSkipped
                  ? Icons.help_outline_rounded
                  : (isCorrect ? Icons.check_rounded : Icons.close_rounded),
              backgroundColor: isSkipped
                  ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.3)
                  : isCorrect
                      ? Colors.green.withOpacity(0.1)
                      : theme.colorScheme.errorContainer.withOpacity(0.1),
              textColor: isSkipped
                  ? theme.colorScheme.onSurfaceVariant
                  : isCorrect
                      ? Colors.green.shade700
                      : theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            _buildAnswerBox(
              context: context,
              label: 'Correct Answer',
              answer: correctAnswer,
              icon: Icons.check_circle_outline_rounded,
              backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.3),
              textColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerBox({
    required BuildContext context,
    required String label,
    required String answer,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: textColor.withOpacity(0.7),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  answer,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, color: textColor, size: 20),
        ],
      ),
    );
  }
}
