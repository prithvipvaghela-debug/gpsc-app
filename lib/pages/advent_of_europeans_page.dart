import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class AdventOfEuropeansPage extends StatelessWidget {
  const AdventOfEuropeansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Advent of Europeans',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Comparative & Rivalry Analysis', horizontalPadding: 0),
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
                    title: 'Advent of Europeans Quiz',
                    subject: 'History',
                    quizId: 'history_advent_europeans_quiz',
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
    "Chronology: Portuguese (1498) ➔ Dutch (1605) ➔ English (1608/13) ➔ Danes (1620) ➔ French (1668).",
    "Portuguese: First to arrive and last to leave (1961). Blue Water Policy by Almeida.",
    "Dutch: Focused on Indonesian Spice Islands; textile exports from India.",
    "English: Established first permanent factory at Surat (1613).",
    "French: Last major power; Anglo-French rivalry led to the Carnatic Wars.",
    "Goal: To bypass Arab and Venetian monopolies over the spice trade."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "The Portuguese Power",
      "content": "Vasco da Gama reached Calicut in 1498 with help from Gujarati pilot Abdul Majid. Alfonso de Albuquerque captured Goa in 1510 and is the real founder."
    },
    {
      "heading": "English EIC & Gujarat",
      "content": "Captain Hawkins visited Jahangir in 1608. Thomas Best's victory at Swally (1612) led to the factory at Surat. Sir Thomas Roe secured further concessions."
    },
    {
      "heading": "The French Challenge",
      "content": "Founded by Colbert under Louis XIV. Francois Martin founded Pondicherry. Dupleix pioneered the 'Subsidiary Alliance' concept."
    },
    {
      "heading": "Carnatic Wars (Anglo-French)",
      "content": "Commercial rivalry in South India. Ended with the Battle of Wandiwash (1760) which effectively finished French political hopes in India."
    }
  ];

  static const List<String> _keyFacts = [
    "Diu & Daman: Acquired by the Portuguese in 1535 and 1559 respectively.",
    "Cartaz System: Portuguese naval license for safe sailing in the Indian Ocean.",
    "Bombay: Given to the English by the Portuguese as dowry in 1661.",
    "Farman of 1717: Issued by Farrukhsiyar, often called the EIC's Magna Carta.",
    "Vasco da Gama: Received by the Hindu ruler Zamorin at Calicut.",
    "Battle of Bedara: Decisive British victory over the Dutch in 1759."
  ];
}
