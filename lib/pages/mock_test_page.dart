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
            title: 'Exam Mode',
            subtitle: 'Real-time countdown, question palette, and marking.',
          ),
          SectionItemCard(
            title: 'Full Length Exam',
            subtitle: '100 Questions • 60 Minutes • All Subjects',
            icon: Icons.timer_rounded,
            isPrimary: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FullLengthTestPage(
                    title: 'Full Length Mock Exam',
                    examId: 'full_exam_mode_1',
                    isUniversal: true,
                    durationMinutes: 60,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Subject Wise Exam',
            subtitle: '50 Questions • 30 Minutes • Targeted Practice',
            icon: Icons.fact_check_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SubjectWiseTestPage(isExamMode: true),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Practice Mode',
            subtitle: 'Instant feedback after each question.',
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
