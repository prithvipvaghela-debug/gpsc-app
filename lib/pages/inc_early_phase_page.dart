import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import 'dynamic_mcq_page.dart';

class INCEarlyPhasePage extends StatelessWidget {
  const INCEarlyPhasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'INC (Early Phase)',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle(context, 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          _buildSectionTitle(context, 'Moderate vs. Extremist Analysis'),
          const SizedBox(height: 12),
          ..._deepNotes.map((note) => _buildDeepNoteCard(context, note)),
          const SizedBox(height: 24),

          _buildSectionTitle(context, 'Key Facts'),
          const SizedBox(height: 12),
          ..._keyFacts.map((fact) => _buildFactCard(context, fact)),
          const SizedBox(height: 32),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DynamicMCQPage(
                    title: 'INC Early Phase Quiz',
                    subject: 'History',
                    quizId: 'history_inc_early_quiz',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.quiz_rounded),
            label: const Text('Start Topic Quiz'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5)),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
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
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.2),
      child: Padding(
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
    "Foundation: Founded in 1885 by A.O. Hume, a retired English civil servant.",
    "First Session: Held at Gokuldas Tejpal Sanskrit College, Bombay, presided by W.C. Bonnerjee.",
    "Moderate Phase (1885-1905): Characterized by constitutional methods, petitions, and faith in British justice.",
    "Extremist Phase (1905-1919): Triggered by the Partition of Bengal; focused on Swaraj, Boycott, and Swadeshi.",
    "Key Moderates: Dadabhai Naoroji, G.K. Gokhale, Pherozeshah Mehta, S.N. Banerjee.",
    "Key Extremists: Lal-Bal-Pal trio (Lala Lajpat Rai, B.G. Tilak, Bipin Chandra Pal) and Aurobindo Ghosh."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Moderates: Aims and Methods",
      "content": "Believed in 'Prayer, Petition, and Protest'. They wanted gradual reforms within the British rule. Their greatest achievement was the Indian Councils Act of 1892. They exposed the economic drain of India (Dadabhai Naoroji's Drain Theory)."
    },
    {
      "heading": "Extremists: Rise and Ideology",
      "content": "Grew due to the failure of Moderates and reactionary policies of Lord Curzon. They demanded 'Swaraj' as a right. Methods included Boycott of foreign goods, promotion of Swadeshi, and National Education."
    },
    {
      "heading": "The Surat Split (1907)",
      "content": "Ideological differences peaked at the Surat session. Moderates wanted Rash Behari Ghosh as president, while Extremists pushed for Tilak or Lajpat Rai. The party split, weakening the movement for nearly a decade."
    },
    {
      "heading": "The Lucknow Pact (1916)",
      "content": "Historic reunion of Moderates and Extremists. Also saw an alliance between the INC and the Muslim League to demand self-government from the British."
    }
  ];

  static const List<String> _keyFacts = [
    "Grand Old Man of India: Dadabhai Naoroji, the first Indian in the British Parliament.",
    "Swaraj Slogan: 'Swaraj is my birthright' given by Lokmanya Tilak.",
    "Safety Valve Theory: Claimed A.O. Hume formed INC to prevent a violent revolution.",
    "Drain Theory: Naoroji's 'Poverty and Un-British Rule in India' exposed economic exploitation.",
    "First Woman President: Annie Besant (1917); First Indian Woman: Sarojini Naidu (1925).",
    "Only Session by Gandhi: Belgaum Session in 1924."
  ];
}
