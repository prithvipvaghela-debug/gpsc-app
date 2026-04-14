import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class FreedomMovementGujaratPage extends StatelessWidget {
  const FreedomMovementGujaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Freedom Movement in Gujarat',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Analysis of Gandhian Movements in Gujarat', horizontalPadding: 0),
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
                    title: 'Gujarat Freedom Quiz',
                    subject: 'History',
                    quizId: 'history_freedom_gujarat_quiz',
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
    "Gandhian Lab: Gujarat served as the primary laboratory for Gandhi's non-violent experiments.",
    "Early Local Wins: Ahmedabad Mill Strike (1918) and Kheda Satyagraha (1918) shaped early nationalism.",
    "The Sardar: Vallabhbhai Patel emerged as a national leader from Borsad and Bardoli Satyagrahas.",
    "Salt Satyagraha: The 1930 Dandi March electrified the entire nation from Gujarat's soil.",
    "Final Struggle: Strong student and worker participation in Ahmedabad during 1942 Quit India Movement.",
    "Integration: Sardar Patel led the merger of hundreds of princely states, including the Junagadh revolt."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Kheda & Ahmedabad (1918)",
      "content": "In Ahmedabad, Gandhi secured a 35% wage hike through his first hunger strike. In Kheda, he led the first non-cooperation movement for revenue remission during crop failure, launching Sardar Patel's political career."
    },
    {
      "heading": "Bardoli Satyagraha (1928)",
      "content": "A perfectly organized no-tax campaign against an unjust 22% tax hike. Success led to tax reduction to 6% and earned Patel the title 'Sardar' from the local women."
    },
    {
      "heading": "Dandi March (1930)",
      "content": "Gandhi and 78 followers walked 385 km to Dandi to break the salt law. This led to mass civil disobedience across India and focused global attention on India's struggle."
    },
    {
      "heading": "Dharasana & Dholera",
      "content": "Following Gandhi's arrest, Sarojini Naidu led the brutalized but non-violent raid on Dharasana salt works. Amritlal Sheth led a successful salt satyagraha in Dholera (Bhal region)."
    }
  ];

  static const List<String> _keyFacts = [
    "Dungli Chor: Title given to Mohanlal Pandya by Gandhi during Kheda struggle.",
    "Vinod Kinariwala: Student martyr of 1942, shot outside Gujarat College.",
    "Arzi Hukumat: The provisional government that led the liberation of Junagadh.",
    "Gujarat Vidyapith: Founded by Gandhi in 1920 for nationalistic education.",
    "Mahadev Desai: Gandhi's secretary who compared Dandi March to Buddha's Great Departure.",
    "Krishnakumarsinhji: Maharaja of Bhavnagar, the first to offer accession to the Indian Union."
  ];
}
