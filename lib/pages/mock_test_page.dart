import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import '../widgets/section_title.dart';
import 'daily_quiz_page.dart';
import 'dynamic_mcq_page.dart';
import 'full_length_test_page.dart';
import 'subject_wise_test_page.dart';
import 'special_gpsc_mcq_screen.dart';

class MockTestPage extends StatelessWidget {
  const MockTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Mock Test',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SectionHeaderCard(
            title: 'Practice with confidence',
            subtitle:
                'Use mock tests to improve speed, accuracy, and exam confidence.',
            icon: Icons.quiz_rounded,
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Test Types',
            subtitle: 'Choose a mode that fits your current study goals.',
          ),
          SectionItemCard(
            title: 'GPSC Full Mock Exam',
            subtitle: 'Attempt real exam pattern test with mixed questions from all subjects',
            icon: Icons.assignment_rounded,
            isPrimary: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DynamicMCQPage(
                    title: 'GPSC Full Mock Exam',
                    isUniversalTest: true,
                    quizId: 'universal_full_mock_exam',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Daily Quiz',
            subtitle: 'Short tests for regular practice and quick revision.',
            icon: Icons.today_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DailyQuizPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Subject Wise Test',
            subtitle: 'Practice one subject at a time and improve weak areas.',
            icon: Icons.checklist_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectWiseTestPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Full Length Test',
            subtitle:
                'Attempt complete exam-style tests to check your preparation level.',
            icon: Icons.timer_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FullLengthTestPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Special GPSC MCQs',
            subtitle: 'Target specific subjects with curated high-yield MCQs.',
            icon: Icons.auto_awesome_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SpecialGpscMcqScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
