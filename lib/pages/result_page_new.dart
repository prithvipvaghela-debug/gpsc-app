import 'package:flutter/material.dart';
import '../widgets/app_banner_ad.dart';
import '../models/quiz_question.dart';
import 'simple_quiz_page.dart';

export '../models/quiz_question.dart';

String _formatScore(double score) {
  if (score % 1 == 0) {
    return score.toInt().toString();
  }
  return score.toStringAsFixed(2);
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
    final double percentage = (score / totalQuestions) * 100;
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // Premium Dark Mode Colors
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : theme.scaffoldBackgroundColor;
    final Color cardColor =
        isDark ? const Color(0xFF1E1E1E) : theme.cardTheme.color ?? Colors.white;
    final Color primaryTextColor =
        isDark ? Colors.white : theme.textTheme.titleLarge?.color ?? Colors.black;
    final Color secondaryTextColor = isDark ? Colors.white70 : Colors.black87;

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

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: const AppBannerAd(),
      appBar: AppBar(
        title: const Text('Quiz Result'),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: child,
            ),
          );
        },
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // TOP RESULT CARD
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
                      padding:
                          const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.4), width: 3),
                            ),
                            child: Icon(resultIcon, size: 42, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                              color: Colors.white24, indent: 40, endIndent: 40),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                _formatScore(score),
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '/$totalQuestions',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${percentage.toStringAsFixed(1)}% Accuracy',
                              style: const TextStyle(
                                fontSize: 15,
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
            const SizedBox(height: 20),

            // SUMMARY ROW
            _buildSummaryRow(
                context: context,
                total: totalQuestions,
                selectedAnswers: selectedAnswers,
                score: score,
                isDark: isDark),

            const SizedBox(height: 24),

            // ACTION BUTTONS
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SimpleQuizPage(
                            title: title, 
                            questions: questions,
                            quizId: quizId,
                          )),
                );
              },
              icon: const Icon(Icons.replay_rounded),
              label: const Text('Retry Quiz'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.menu_book_rounded),
              label: const Text('Back to Chapters'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 64),
                side: BorderSide(color: theme.colorScheme.primary, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                foregroundColor: theme.colorScheme.primary,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(height: 32),
            Text(
              'Detailed Review',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: primaryTextColor),
            ),
            const SizedBox(height: 16),

            // QUESTION LIST
            for (int index = 0; index < questions.length; index++) ...[
              _buildQuestionResultCard(
                context: context,
                questionNumber: index + 1,
                question: questions[index],
                selectedAnswerIndex: selectedAnswers[index],
                cardColor: cardColor,
                primaryTextColor: primaryTextColor,
                secondaryTextColor: secondaryTextColor,
                isDark: isDark,
              ),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required BuildContext context,
    required int total,
    required List<int?> selectedAnswers,
    required double score,
    required bool isDark,
  }) {
    final int correct = score.toInt();
    final int skipped = selectedAnswers.where((a) => a == null).length;
    final int wrong = total - correct - skipped;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
                color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSummaryItem(context, 'Total', total.toString(),
              Icons.assignment_rounded, Colors.blue, isDark),
          _buildVerticalDivider(isDark),
          _buildSummaryItem(context, 'Correct', correct.toString(),
              Icons.check_circle_rounded, Colors.green, isDark),
          _buildVerticalDivider(isDark),
          _buildSummaryItem(context, 'Wrong', wrong.toString(),
              Icons.cancel_rounded, Colors.red, isDark),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(bool isDark) {
    return Container(
        height: 40, width: 1, color: isDark ? Colors.white12 : Colors.black12);
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value,
      IconData icon, Color color, bool isDark) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black),
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white60 : Colors.black54),
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
    required Color cardColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,
    required bool isDark,
  }) {
    final bool isSkipped = selectedAnswerIndex == null;
    final bool isCorrect = selectedAnswerIndex == question.correctAnswerIndex;
    final String selectedAnswer =
        isSkipped ? 'Skipped' : question.options[selectedAnswerIndex];
    final String correctAnswer = question.options[question.correctAnswerIndex];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
                color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $questionNumber',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary),
              ),
              if (!isSkipped)
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? Colors.greenAccent : Colors.redAccent,
                  size: 22,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question.question,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: primaryTextColor,
                height: 1.4),
          ),
          const SizedBox(height: 20),
          _buildAnswerBox(
            context: context,
            label: 'Your Answer',
            answer: selectedAnswer,
            icon: isSkipped
                ? Icons.help_outline_rounded
                : (isCorrect ? Icons.check_circle : Icons.cancel),
            backgroundColor: isSkipped
                ? (isDark ? Colors.white10 : const Color(0xFFF5F7F9))
                : (isCorrect
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.15)),
            textColor: isSkipped
                ? (isDark ? Colors.white60 : Colors.blueGrey)
                : (isCorrect ? Colors.greenAccent : Colors.redAccent),
            labelColor: isDark ? Colors.white60 : Colors.grey[700]!,
          ),
          const SizedBox(height: 12),
          _buildAnswerBox(
            context: context,
            label: 'Correct Answer',
            answer: correctAnswer,
            icon: Icons.check_circle,
            backgroundColor: isDark
                ? Colors.blueAccent.withOpacity(0.15)
                : const Color(0xFFE3F2FD),
            textColor: isDark
                ? Colors.blueAccent
                : Theme.of(context).colorScheme.primary,
            labelColor: isDark ? Colors.white60 : Colors.grey[700]!,
          ),
        ],
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
    required Color labelColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(16)),
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
                      color: labelColor,
                      letterSpacing: 0.5),
                ),
                const SizedBox(height: 4),
                Text(
                  answer,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700, color: textColor),
                ),
              ],
            ),
          ),
          Icon(icon, color: textColor, size: 24),
        ],
      ),
    );
  }
}
