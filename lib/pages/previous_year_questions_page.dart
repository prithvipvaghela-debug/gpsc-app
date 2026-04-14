import 'package:flutter/material.dart';

import 'prelims_questions_2017_2025_page.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import '../widgets/section_title.dart';

class PreviousYearQuestionsPage extends StatelessWidget {
  const PreviousYearQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Previous Papers',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SectionHeaderCard(
            title: 'Analyze past papers',
            subtitle:
                'Understanding the exam pattern from previous years is the key to success.',
            icon: Icons.history_rounded,
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Available Papers',
            subtitle: 'Real questions from previous GPSC exams.',
          ),
          SectionItemCard(
            title: '2017 to 2025 Prelims',
            subtitle: 'Solve prelims questions from the last 8 years.',
            icon: Icons.description_rounded,
            isPrimary: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrelimsQuestions2017To2025Page(),
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
