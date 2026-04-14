import 'package:flutter/material.dart';

import 'simple_quiz_page.dart';

class SubjectWiseTestPage extends StatelessWidget {
  const SubjectWiseTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleQuizPage(
      title: 'Subject Wise Test',
      quizId: 'subject_wise_test',
      questions: [
        QuizQuestion(
          question: 'Who is known as the Father of the Indian Constitution?',
          options: [
            'Mahatma Gandhi',
            'Dr. B. R. Ambedkar',
            'Jawaharlal Nehru',
            'Sardar Patel',
          ],
          correctAnswerIndex: 1,
        ),
      ],
    );
  }
}
