import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class RevolutionaryMovementsPage extends StatelessWidget {
  const RevolutionaryMovementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Revolutionary Movements',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Analysis of Revolutionary Groups'),
          const SizedBox(height: 12),
          ..._deepNotes.map((note) => _buildDeepNoteCard(context, note)),
          const SizedBox(height: 24),

          const SectionTitle(title: 'Key Facts'),
          const SizedBox(height: 12),
          ..._keyFacts.map((fact) => _buildFactCard(context, fact)),
          const SizedBox(height: 32),

          AppButton(
            label: 'Start Topic Quiz',
            icon: Icons.quiz_rounded,
            type: AppButtonType.primary,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DynamicMCQPage(
                    title: 'Revolutionary Quiz',
                    subject: 'History',
                    quizId: 'history_revolutionary_quiz',
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              )),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeepNoteCard(BuildContext context, Map<String, String> note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppCard(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['heading'] ?? '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              note['content'] ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactCard(BuildContext context, String fact) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.info_outline_rounded, size: 20, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 12),
            Expanded(child: Text(fact, style: const TextStyle(fontSize: 14))),
          ],
        ),
      ),
    );
  }

  static const List<String> _quickNotes = [
    "Origin: Frustration with moderate petitions and the aftermath of the Swadeshi Movement.",
    "Phase 1: Individual heroic actions and assassinations of British officials.",
    "Phase 2: Post-NCM, influenced by socialism and mass class-struggle (HSRA).",
    "Key Groups: Abhinav Bharat, Anushilan Samiti, HRA/HSRA, and the INA.",
    "Global Presence: Ghadar Party (USA) and India House (London).",
    "Goal: Complete independence through armed revolution and mass awakening."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Early Secret Societies",
      "content": "V.D. Savarkar founded 'Abhinav Bharat' (1904). Bengal saw the rise of 'Anushilan Samiti' and 'Yugantar', focusing on physical training and revolutionary propaganda."
    },
    {
      "heading": "HRA & HSRA (The Socialists)",
      "content": "HRA (1924) executed the Kakori robbery. Bhagat Singh and Azad transformed it into HSRA (1928), adding 'Socialist' to represent mass struggle and equality."
    },
    {
      "heading": "Bhagat Singh's Ideology",
      "content": "Shifted from individual actions to mass revolution. Bombing the Assembly was to 'make the deaf hear'. Martyrs' Day (March 23) honors Singh, Sukhdev, and Rajguru."
    },
    {
      "heading": "Subhash Chandra Bose & INA",
      "content": "Bose formed the 'Forward Bloc' and later revitalized the INA in Singapore (1943). The INA's Rani of Jhansi Regiment was a unique women's combat unit."
    }
  ];

  static const List<String> _keyFacts = [
    "India House: Founded by Shyamji Krishna Varma in London.",
    "Ghadar Party: Headquartered at San Francisco, founded by Lala Hardayal.",
    "Surya Sen: Mastermind of the Chittagong Armoury Raid (1930).",
    "Udham Singh: Assassinated Michael O'Dwyer in London (1940).",
    "Madame Cama: First to hoist the Indian flag on foreign soil (Germany, 1907).",
    "Jatin Das: Died in jail after a historic 63-day hunger strike."
  ];
}
