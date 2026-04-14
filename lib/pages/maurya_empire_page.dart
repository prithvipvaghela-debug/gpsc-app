import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class MauryaEmpirePage extends StatelessWidget {
  const MauryaEmpirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Maurya Empire',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Imperial Analysis'),
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
                    title: 'Maurya Empire Quiz',
                    subject: 'History',
                    quizId: 'history_maurya_quiz',
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
    "Time Period: 322 BCE to 185 BCE. Founded by Chandragupta Maurya.",
    "Key Guide: Chanakya (Kautilya), author of 'Arthashastra'.",
    "Capital: Pataliputra (modern Patna).",
    "Major Rulers: Chandragupta Maurya, Bindusara, Ashoka the Great.",
    "First Pan-Indian Empire: Centralized administration and extensive espionage system.",
    "Key Sources: Arthashastra, Indica (Megasthenes), Mudrarakshasa, and Ashokan Edicts."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Chandragupta & Bindusara",
      "content": "Chandragupta defeated Seleucus Nicator in 305 BCE and acquired the North-West. He later embraced Jainism. Bindusara, known as 'Amitraghata', expanded into the Deccan and patronized the Ajivika sect."
    },
    {
      "heading": "Ashoka the Great & Dhamma",
      "content": "The Kalinga War (261 BCE) was the turning point, leading Ashoka to embrace Buddhism and 'Dhammaghosha'. His Dhamma was a moral code emphasizing Ahimsa and religious tolerance."
    },
    {
      "heading": "Mauryan Administration",
      "content": "Highly centralized. King assisted by Mantriparishad. Key officials: Samaharta (Revenue) and Sannidhata (Treasurer). Division into provinces (Chakras) ruled by Kumaras."
    },
    {
      "heading": "Gujarat Connection: Sudarshana Lake",
      "content": "Constructed by Pushyagupta (Governor under Chandragupta) in Saurashtra. Later, canals were drawn by Tushaspha under Ashoka. Details found in Rudradaman's Junagadh inscription."
    }
  ];

  static const List<String> _keyFacts = [
    "James Prinsep: First to decipher Brahmi script of Ashokan edicts in 1837.",
    "Devanampiya Piyadasi: Common title for Ashoka in inscriptions.",
    "Saptanga Theory: State's 7 elements - King, Minister, Territory, Fort, Treasury, Army, Ally.",
    "Sarnath Pillar: The Lion Capital is India's National Emblem.",
    "Last Ruler: Brihadratha, assassinated by Pushyamitra Shunga in 185 BCE.",
    "Indica: Written by Megasthenes, mentions 7 classes in Indian society."
  ];
}
