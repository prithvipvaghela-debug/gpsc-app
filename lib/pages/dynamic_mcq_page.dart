import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../services/persistence_service.dart';
import '../services/analytics_service.dart';
import '../services/mcq_loader.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/app_card.dart';
import '../widgets/app_option_button.dart';
import 'simple_quiz_page.dart'; // Import for ResultPage and QuizQuestion

class DynamicMCQPage extends StatefulWidget {
  const DynamicMCQPage({
    super.key,
    required this.title,
    this.quizId,
    this.subject,
    this.isUniversalTest = false,
  });

  final String title;
  final String? quizId;
  final String? subject;
  final bool isUniversalTest;

  @override
  State<DynamicMCQPage> createState() => _DynamicMCQPageState();
}

class _DynamicMCQPageState extends State<DynamicMCQPage> {
  static const int _questionTimeInSeconds = 30;
  static const double _correctMark = 1.0;
  static const double _wrongMark = 0.33;

  List<QuizQuestion> _quizQuestions = [];
  bool _isLoading = true;
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  double _score = 0;
  int _timeLeft = _questionTimeInSeconds;
  Timer? _timer;
  late List<int?> _selectedAnswers;
  
  late QuizStats _stats;

  String _formatScore(double score) {
    if (score % 1 == 0) {
      return score.toInt().toString();
    }
    return score.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final List<dynamic> allMcqs = await MCQLoader.loadMCQs();
      List<dynamic> mcqList;

      if (widget.isUniversalTest) {
        mcqList = List.from(allMcqs);
        mcqList.shuffle(Random());
        mcqList = mcqList.take(100).toList();
      } else if (widget.subject != null) {
        mcqList = allMcqs.where((item) => item['topic'] == widget.subject).toList();
        mcqList.shuffle(Random());
        mcqList = mcqList.take(20).toList();
      } else {
        mcqList = List.from(allMcqs);
        mcqList.shuffle(Random());
        mcqList = mcqList.take(20).toList();
      }

      setState(() {
        _quizQuestions = mcqList.map((item) {
          final List<String> options = List<String>.from(item['options']);
          final String answer = item['answer'];
          final int correctIndex = options.indexOf(answer);
          
          return QuizQuestion(
            question: item['question'],
            options: options,
            correctAnswerIndex: correctIndex != -1 ? correctIndex : 0,
          );
        }).toList();
        
        _selectedAnswers = List<int?>.filled(_quizQuestions.length, null);
        _isLoading = false;
        _loadStats();
        _startTimer();
      });
    } catch (e) {
      debugPrint('Error loading dynamic MCQs: $e');
      setState(() {
        _isLoading = false;
      });
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
    if (_selectedAnswerIndex == null && !allowUnanswered) {
      return;
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
    
    AnalyticsService().saveTestResult(widget.subject ?? 'General', correctCount, wrongCount);

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
    if (_isLoading) {
      return const GpscPageScaffold(
        title: 'Loading Quiz...',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_quizQuestions.isEmpty) {
      return GpscPageScaffold(
        title: widget.title,
        child: const Center(child: Text('No questions found.')),
      );
    }

    return GpscPageScaffold(
      title: widget.title,
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
