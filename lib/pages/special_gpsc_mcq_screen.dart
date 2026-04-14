import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import 'dynamic_mcq_page.dart';

class SpecialGpscMcqScreen extends StatelessWidget {
  const SpecialGpscMcqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Special GPSC MCQs',
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeaderCard(
            title: 'Topic Wise Preparation',
            subtitle:
                'Target specific subjects with curated high-yield MCQs for GPSC exams.',
            icon: Icons.auto_awesome_rounded,
          ),
          const SizedBox(height: 24),
          SectionItemCard(
            title: 'History MCQs',
            subtitle: 'Ancient, Medieval, and Modern Indian History.',
            icon: Icons.history_edu_rounded,
            onTap: () {
              _startDynamicQuiz(context, 'History');
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Polity MCQs',
            subtitle: 'Indian Constitution, Governance, and Political System.',
            icon: Icons.gavel_rounded,
            onTap: () {
              _startDynamicQuiz(context, 'Polity');
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Geography MCQs',
            subtitle: 'Indian and World Geography with focus on Gujarat.',
            icon: Icons.public_rounded,
            onTap: () {
              _startDynamicQuiz(context, 'Geography');
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Economy MCQs',
            subtitle: 'Indian Economy, Budget, and Planning.',
            icon: Icons.account_balance_rounded,
            onTap: () {
              _startDynamicQuiz(context, 'Economy');
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _startDynamicQuiz(BuildContext context, String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DynamicMCQPage(
          title: '$subject Quiz',
          subject: subject,
          quizId: 'dynamic_${subject.toLowerCase()}',
        ),
      ),
    );
  }
}
