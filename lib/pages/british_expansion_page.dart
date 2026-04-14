import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class BritishExpansionPage extends StatelessWidget {
  const BritishExpansionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'British Expansion',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Expansionist Strategies & Consolidation', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._deepNotes.map((note) => _buildDeepNoteCard(context, note)),
          const SizedBox(height: 24),

          const SectionTitle(title: 'Key Facts', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._keyFacts.map((fact) => _buildFactCard(context, fact)),
          const SizedBox(height: 32),

          AppButton(
            label: 'Start Topic Quiz',
            icon: Icons.quiz_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DynamicMCQPage(
                    title: 'British Expansion Quiz',
                    subject: 'History',
                    quizId: 'history_british_expansion_quiz',
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
        borderRadius: 16,
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
        borderRadius: 12,
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
    "Turning Points: Battle of Plassey (1757) and Battle of Buxar (1764) established British rule.",
    "Buxar Result: Secured Diwani rights (revenue collection) for Bengal, Bihar, and Orissa.",
    "Dual Government: Introduced by Robert Clive; power stayed with EIC, responsibility with the Nawab.",
    "Subsidiary Alliance: Lord Wellesley's strategy to subordinate Indian states.",
    "Doctrine of Lapse: Lord Dalhousie's policy to annex states without natural male heirs.",
    "Consolidation: Warren Hastings and Lord Cornwallis built the administrative foundation."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "The Conquest of Bengal",
      "content": "Plassey was won through the betrayal of Mir Jafar. Buxar was a military triumph over a combined Indian alliance, leading to the Treaty of Allahabad (1765)."
    },
    {
      "heading": "The Subsidiary Alliance System",
      "content": "Indian rulers had to maintain British troops and a Resident, losing their foreign policy independence. The Nizam of Hyderabad was the first to join (1798)."
    },
    {
      "heading": "Lord Dalhousie & Annexations",
      "content": "Dalhousie annexed Satara, Jhansi, and Nagpur using the Doctrine of Lapse. He famously annexed Awadh in 1856 based on charges of misgovernance."
    },
    {
      "heading": "Father of Civil Services",
      "content": "Lord Cornwallis organized and professionalized the civil services, separating revenue and judicial branches to reduce corruption."
    }
  ];

  static const List<String> _keyFacts = [
    "Black Hole Tragedy: Pretence used for the EIC attack on Bengal in 1757.",
    "Treaty of Bassein (1802): Maratha Peshwa Baji Rao II accepted the Subsidiary Alliance.",
    "Treaty of Seringapatam (1792): Tipu Sultan surrendered half his kingdom to the British.",
    "Anandrao Gaekwad: Maratha ruler of Baroda who joined the Subsidiary Alliance in 1802.",
    "Warren Hastings: First Governor-General of Bengal (1773).",
    "Mir Jafar: The commander whose betrayal at Plassey paved the way for British rule."
  ];
}
