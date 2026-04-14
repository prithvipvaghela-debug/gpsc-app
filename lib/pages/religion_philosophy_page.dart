import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class ReligionPhilosophyPage extends StatelessWidget {
  const ReligionPhilosophyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Religion & Philosophy',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Philosophical Analysis', horizontalPadding: 0),
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
                    title: 'Buddhism & Jainism Quiz',
                    subject: 'History',
                    quizId: 'history_religion_quiz',
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
    "Origin: 6th Century BCE heterodox reaction against rigid Varna and expensive sacrifices.",
    "Commonalities: Rejected Vedas, opposed animal sacrifices, believed in Karma and Rebirth.",
    "Jainism Founder: 24 Tirthankaras; Rishabhanatha (1st) and Mahavira (24th/historical).",
    "Buddhism Founder: Gautama Buddha (Siddhartha) of the Shakya clan.",
    "Languages: Pali (Buddhism) and Prakrit (Jainism) to reach the masses.",
    "Gujarat Connection: 2nd Jain Council held at Valabhi, Gujarat."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Jainism & Mahavira",
      "content": "Mahavira attained 'Kaivalya' at 42 on the Rijupalika river. Core philosophies include 'Anekantavada' (multiple realities) and 'Syadvada'. Added 'Brahmacharya' to the four existing vows."
    },
    {
      "heading": "Buddhism & Buddha",
      "content": "Siddhartha attained 'Nirvana' at 35 in Bodh Gaya. Preached the 'Middle Path' and the 'Four Noble Truths'. 4th Council in Kashmir split Buddhism into Hinayana and Mahayana."
    },
    {
      "heading": "The Five Vows of Jainism",
      "content": "1. Ahimsa (Non-violence), 2. Satya (Truth), 3. Asteya (Non-stealing), 4. Aparigraha (Non-possession), 5. Brahmacharya (added by Mahavira)."
    },
    {
      "heading": "Valabhi Council (Gujarat Significance)",
      "content": "Held in 512 CE at Valabhi under Devardhi Kshamasramana. Resulted in the final compilation and writing down of Jain Agamas."
    }
  ];

  static const List<String> _keyFacts = [
    "Triratna (Jainism): Right Faith, Right Knowledge, Right Conduct.",
    "Tripitaka: Vinaya Pitaka (Rules), Sutta Pitaka (Teachings), Abhidhamma Pitaka (Philosophy).",
    "Jain Sects: Digambaras (Sky-clad) and Svetambaras (White-clad).",
    "Mahayana: Worshipped Buddha as a god; Hinayana: Original teachings.",
    "Jataka Tales: Stories of Buddha's previous births.",
    "Valabhi: Major center of learning and the location of the 2nd Jain Council."
  ];
}
