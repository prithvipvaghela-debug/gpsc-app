import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import '../widgets/section_title.dart';
import 'history_screen.dart';

class StudyMaterialScreen extends StatelessWidget {
  const StudyMaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Study Material',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SectionTitle(
            title: 'Core Subjects',
            subtitle: 'Comprehensive notes for GPSC Prelims and Mains.',
          ),
          SectionItemCard(
            title: 'History',
            subtitle: 'Ancient, Medieval, and Modern history including Gujarat.',
            icon: Icons.history_edu_rounded,
            isPrimary: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Polity',
            subtitle: 'Indian Constitution, governance, and political system.',
            icon: Icons.gavel_rounded,
            isPrimary: true,
            onTap: () {
              // Navigation to be implemented
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Geography',
            subtitle: 'Physical, social, and economic geography of India and Gujarat.',
            icon: Icons.public_rounded,
            isPrimary: true,
            onTap: () {
              // Navigation to be implemented
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Economy',
            subtitle: 'Indian economy, budget, and economic developments.',
            icon: Icons.account_balance_rounded,
            isPrimary: true,
            onTap: () {
              // Navigation to be implemented
            },
          ),
          const SizedBox(height: 24),
          const SectionTitle(
            title: 'Science & Technology',
            subtitle: 'Modern tech, space, and general science.',
          ),
          SectionItemCard(
            title: 'General Science',
            subtitle: 'Biology, Physics, and Chemistry basics.',
            icon: Icons.science_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Environment',
            subtitle: 'Ecology, biodiversity, and climate change.',
            icon: Icons.eco_rounded,
            onTap: () {},
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
