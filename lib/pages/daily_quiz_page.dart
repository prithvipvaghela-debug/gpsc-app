import 'package:flutter/material.dart';
import '../models/quiz_question.dart';
import 'simple_quiz_page.dart';

class DailyQuizPage extends StatelessWidget {
  const DailyQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleQuizPage(
      title: 'Daily Quiz',
      quizId: 'daily_quiz',
      questions: [
        QuizQuestion(
          question: 'What is the capital of Gujarat?',
          options: ['Ahmedabad', 'Surat', 'Gandhinagar', 'Rajkot'],
          correctAnswerIndex: 2,
        ),
      ],
    );
  }
}
