import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class GuptaEmpirePage extends StatelessWidget {
  const GuptaEmpirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Gupta Empire',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Imperial Analysis', horizontalPadding: 0),
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
                    title: 'Gupta Empire Quiz',
                    subject: 'History',
                    quizId: 'history_gupta_quiz',
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
    "Time Period: ~319 CE to 540 CE. Known as the 'Golden Age' of ancient India.",
    "Founder: Sri Gupta (Real founder: Chandragupta I).",
    "Capital: Pataliputra (Secondary capital: Ujjain).",
    "Key Rulers: Chandragupta I, Samudragupta, Chandragupta II, Kumaragupta, Skandagupta.",
    "Language: Sanskrit was the official court language.",
    "Decline: Weak successors and continuous Huna invasions led to the empire's fall."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Samudragupta: The Napoleon of India",
      "content": "A brilliant military general whose conquests are detailed in the Allahabad Pillar Inscription (Prayag Prashasti) by Harisena. He was also a lover of music and is depicted playing the Veena on his coins."
    },
    {
      "heading": "Chandragupta II (Vikramaditya)",
      "content": "Expanded the empire by defeating the Shakas of Gujarat. His court featured the 'Navaratnas' (Nine Gems) including Kalidasa. The Chinese traveler Fa-Hien visited during his reign."
    },
    {
      "heading": "Decentralized Administration",
      "content": "Unlike the Mauryas, the Guptas had a decentralized system with a focus on feudalism. Provinces were called Bhuktis ruled by Uparikas. Land grants (Agraharas) became common."
    },
    {
      "heading": "Scientific & Literary Zenith",
      "content": "Aryabhata (Mathematics/Astronomy), Varahamihira (Cosmology), and Kalidasa (Literature) represent the intellectual peak of this era. Structural Hindu temples began appearing in the Nagara style."
    }
  ];

  static const List<String> _keyFacts = [
    "Nalanda University: Founded by Kumaragupta I in modern Bihar.",
    "Mehrauli Iron Pillar: Rust-resistant pillar associated with Chandragupta II.",
    "Sudarshana Lake: Repaired by Chakrapalita under Skandagupta's reign.",
    "Sati: First epigraphic evidence found in the Eran Inscription (510 CE).",
    "Dinara: The gold coins issued by the Gupta emperors.",
    "Barygaza (Bharuch): The major western port for maritime trade."
  ];
}
