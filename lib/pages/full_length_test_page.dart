import 'dart:math';
import 'package:flutter/material.dart';
import '../services/exam_controller.dart';
import '../services/analytics_service.dart';
import '../services/persistence_service.dart';
import '../services/mcq_loader.dart';
import '../models/quiz_question.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/app_card.dart';
import '../widgets/app_option_button.dart';
import 'result_page_new.dart';

class FullLengthTestPage extends StatefulWidget {
  const FullLengthTestPage({
    super.key,
    this.title = 'Full Length Mock Test',
    this.examId = 'full_mock_exam',
    this.subject,
    this.isUniversal = true,
    this.durationMinutes = 60,
  });

  final String title;
  final String examId;
  final String? subject;
  final bool isUniversal;
  final int durationMinutes;

  @override
  State<FullLengthTestPage> createState() => _FullLengthTestPageState();
}

class _FullLengthTestPageState extends State<FullLengthTestPage> {
  ExamController? _controller;
  bool _isLoading = true;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final List<dynamic> allMcqs = await MCQLoader.loadMCQs();
      List<dynamic> filtered;

      if (widget.isUniversal) {
        filtered = List.from(allMcqs);
        filtered.shuffle(Random());
        filtered = filtered.take(100).toList();
      } else if (widget.subject != null) {
        filtered = allMcqs.where((item) => item['topic'] == widget.subject).toList();
        filtered.shuffle(Random());
        filtered = filtered.take(50).toList();
      } else {
        filtered = List.from(allMcqs);
        filtered.shuffle(Random());
        filtered = filtered.take(50).toList();
      }

      final List<QuizQuestion> questions = filtered.map((item) {
        final List<String> options = List<String>.from(item['options']);
        final int correctIndex = options.indexOf(item['answer']);
        return QuizQuestion(
          question: item['question'],
          options: options,
          correctAnswerIndex: correctIndex != -1 ? correctIndex : 0,
        );
      }).toList();

      if (!mounted) return;

      setState(() {
        _controller = ExamController(
          questions: questions,
          examId: widget.examId,
          totalDurationSeconds: widget.durationMinutes * 60,
        );
        _isLoading = false;
        _controller!.startTimer(() {
          _submitExam(autoSubmit: true);
        });
        
        // Listen to index changes to sync PageView
        _controller!.currentIndex.addListener(() {
          if (_pageController.hasClients && 
              _pageController.page?.round() != _controller!.currentIndex.value) {
            _pageController.animateToPage(
              _controller!.currentIndex.value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      });
    } catch (e) {
      debugPrint('Error loading exam questions: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final int h = seconds ~/ 3600;
    final int m = (seconds % 3600) ~/ 60;
    final int s = seconds % 60;
    if (h > 0) {
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _submitExam({bool autoSubmit = false}) {
    if (_controller == null) return;

    if (autoSubmit) {
      _navigateToResult();
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Exam?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Attempted: ${_controller!.attemptedCount}'),
            Text('Unattempted: ${_controller!.unattemptedCount}'),
            Text('Marked for Review: ${_controller!.markedCount}'),
            const SizedBox(height: 16),
            const Text('Are you sure you want to submit your test?'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToResult();
            },
            child: const Text('SUBMIT'),
          ),
        ],
      ),
    );
  }

  void _navigateToResult() {
    final results = _controller!.calculateResults();
    final double score = results['score'];
    final int correctCount = results['correct'];
    final int wrongCount = results['wrong'];

    AnalyticsService().saveTestResult(widget.title, correctCount, wrongCount);
    PersistenceService().saveQuizScore(widget.examId, score);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          title: widget.title,
          questions: _controller!.questions,
          selectedAnswers: _controller!.selectedAnswers,
          score: score,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const GpscPageScaffold(
        title: 'Loading Exam...',
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_controller == null || _controller!.questions.isEmpty) {
      return GpscPageScaffold(
        title: widget.title,
        child: const Center(child: Text('No questions found for this exam.')),
      );
    }

    final theme = Theme.of(context);

    return GpscPageScaffold(
      title: widget.title,
      actions: [
        // Granular rebuild for timer only
        ValueListenableBuilder<int>(
          valueListenable: _controller!.timeLeft,
          builder: (context, seconds, _) {
            final isCritical = seconds < 300;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isCritical ? theme.colorScheme.errorContainer : theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.timer_outlined, 
                    size: 14, 
                    color: isCritical ? theme.colorScheme.error : theme.colorScheme.onSecondaryContainer
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(seconds),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isCritical ? theme.colorScheme.error : theme.colorScheme.onSecondaryContainer,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
      drawer: _buildQuestionPalette(theme),
      child: Column(
        children: [
          // Question Header - Granular rebuild for index only
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ValueListenableBuilder<int>(
                  valueListenable: _controller!.currentIndex,
                  builder: (context, index, _) {
                    return Text(
                      'Question ${index + 1} / ${_controller!.questions.length}',
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    );
                  },
                ),
                Builder(
                  builder: (context) => TextButton.icon(
                    icon: const Icon(Icons.grid_view_rounded, size: 18),
                    label: const Text('Palette'),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ],
            ),
          ),

          // Question Body with PageView for smooth sliding transitions
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => _controller!.jumpToQuestion(index),
              itemCount: _controller!.questions.length,
              itemBuilder: (context, index) {
                return _buildQuestionItem(context, index, theme);
              },
            ),
          ),

          // Footer Navigation
          _buildFooterActions(theme),
        ],
      ),
    );
  }

  Widget _buildQuestionItem(BuildContext context, int index, ThemeData theme) {
    final question = _controller!.questions[index];
    
    // ListenableBuilder for answer selection updates within this question
    return ListenableBuilder(
      listenable: _controller!,
      builder: (context, _) {
        final selectedIndex = _controller!.selectedAnswers[index];
        
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Text(
                  question.question,
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.5, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(question.options.length, (optIndex) {
                return AppOptionButton(
                  option: question.options[optIndex],
                  index: optIndex,
                  onTap: () => _controller!.selectAnswer(index, optIndex),
                  isSelected: selectedIndex == optIndex,
                  isCorrect: false,
                  isWrong: false,
                  showResult: false,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooterActions(ThemeData theme) {
    return ListenableBuilder(
      listenable: _controller!,
      builder: (context, _) {
        final index = _controller!.currentIndex.value;
        final isMarked = _controller!.markedForReview[index];
        final isLast = index == _controller!.questions.length - 1;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () => _controller!.toggleMarkForReview(index),
                    icon: Icon(isMarked ? Icons.bookmark_added : Icons.bookmark_add_outlined, size: 18),
                    label: Text(isMarked ? 'Marked' : 'Review Later'),
                    style: TextButton.styleFrom(
                      foregroundColor: isMarked ? Colors.purple : theme.colorScheme.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => _controller!.selectAnswer(index, -1),
                    child: const Text('Clear'),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: index > 0 ? _controller!.previousQuestion : null,
                      child: const Text('PREV'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLast ? _submitExam : _controller!.nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLast ? Colors.green : theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(isLast ? 'SUBMIT' : 'NEXT'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuestionPalette(ThemeData theme) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: theme.colorScheme.primaryContainer,
              child: Row(
                children: [
                  const Icon(Icons.grid_view_rounded),
                  const SizedBox(width: 12),
                  const Text('Navigation Palette', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                spacing: 12, runSpacing: 6,
                children: [
                  _buildLegendItem('Ans', Colors.green),
                  _buildLegendItem('Not Ans', Colors.red.shade400),
                  _buildLegendItem('Marked', Colors.purple),
                  _buildLegendItem('Empty', Colors.grey.shade300),
                ],
              ),
            ),

            const Divider(),

            Expanded(
              child: ListenableBuilder(
                listenable: _controller!,
                builder: (context, _) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, crossAxisSpacing: 8, mainAxisSpacing: 8,
                    ),
                    itemCount: _controller!.questions.length,
                    itemBuilder: (context, index) {
                      final status = _controller!.getStatus(index);
                      Color bgColor;
                      Color textColor = Colors.white;

                      switch (status) {
                        case QuestionStatus.answered: bgColor = Colors.green; break;
                        case QuestionStatus.notAnswered: bgColor = Colors.red.shade400; break;
                        case QuestionStatus.markedForReview: bgColor = Colors.purple; break;
                        case QuestionStatus.notVisited:
                        default: bgColor = Colors.grey.shade300; textColor = Colors.black87; break;
                      }

                      final bool isCurrent = _controller!.currentIndex.value == index;

                      return GestureDetector(
                        onTap: () {
                          _controller!.jumpToQuestion(index);
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(8),
                            border: isCurrent ? Border.all(color: theme.colorScheme.primary, width: 2) : null,
                          ),
                          alignment: Alignment.center,
                          child: Text('${index + 1}', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }
}
