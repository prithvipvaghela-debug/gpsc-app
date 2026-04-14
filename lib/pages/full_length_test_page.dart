import 'package:flutter/material.dart';

import 'simple_quiz_page.dart';

class FullLengthTestPage extends StatelessWidget {
  const FullLengthTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleQuizPage(
      title: 'Full Length Test',
      quizId: 'full_length_test',
      questions: [
        QuizQuestion(
          question: 'Who is the current constitutional head of an Indian state?',
          options: ['Chief Minister', 'Governor', 'Speaker', 'Collector'],
          correctAnswerIndex: 1,
        ),
      ],
    );
  }
}
