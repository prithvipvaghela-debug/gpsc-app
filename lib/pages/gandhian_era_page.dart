import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class GandhianEraPage extends StatelessWidget {
  const GandhianEraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Gandhian Era',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Analysis of Gandhian Movements'),
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
                    title: 'Gandhian Era Quiz',
                    subject: 'History',
                    quizId: 'history_gandhian_era_quiz',
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
    "Arrival: Gandhi returned from South Africa on Jan 9, 1915 (Pravasi Bharatiya Divas).",
    "Early Successes: Champaran (1917), Ahmedabad Mill Strike (1918), Kheda (1918).",
    "NCM (1920-22): First mass movement, withdrawn after Chauri Chaura incident.",
    "CDM (1930): Launched with the Dandi March to break the unjust salt law.",
    "QIM (1942): The final 'Do or Die' struggle for complete independence.",
    "Philosophy: Anchored in Ahimsa (Non-violence) and Satyagraha (Truth-force)."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Early Local Struggles (1917-1918)",
      "content": "Champaran (Bihar): Fought against the Tinkathia system. Ahmedabad (Gujarat): First hunger strike for mill workers' wages. Kheda (Gujarat): First non-cooperation for revenue remission."
    },
    {
      "heading": "The Salt Satyagraha & Dandi March",
      "content": "Gandhi walked 240 miles from Sabarmati to Dandi (March 12 - April 6, 1930). Salt was chosen as a unifying symbol for all Indians. Led to mass civil disobedience nationwide."
    },
    {
      "heading": "Quit India Movement (1942)",
      "content": "Launched after the failure of the Cripps Mission. Spontaneous mass uprising. Key underground leaders: Usha Mehta (Secret Radio), Aruna Asaf Ali, and JP Narayan."
    },
    {
      "heading": "Constructive Programme",
      "content": "Gandhi focused on social reforms alongside political struggle: Removal of untouchability, Hindu-Muslim unity, and promotion of Khadi (Charkha)."
    }
  ];

  static const List<String> _keyFacts = [
    "Political Guru: Gopal Krishna Gokhale.",
    "Titles given up: Returned 'Kaiser-i-Hind' during the NCM protest.",
    "Poona Pact (1932): Signed between Gandhi and Ambedkar regarding reserved seats.",
    "Dharasana: Famous non-violent raid on salt works led by Sarojini Naidu.",
    "Belgaum Session (1924): The only INC session presided over by Gandhi.",
    "Sardar Patel: Emerged as a national leader during the Kheda and Bardoli Satyagrahas."
  ];
}
