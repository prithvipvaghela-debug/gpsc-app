import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class LothalDholaviraPage extends StatelessWidget {
  const LothalDholaviraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Lothal & Dholavira',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Comparative Site Analysis'),
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
                    title: 'Lothal & Dholavira Quiz',
                    subject: 'History',
                    quizId: 'history_lothal_dholavira_quiz',
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
    "Gujarat host highest number of Harappan sites in post-independence India.",
    "Lothal: Discovered by S.R. Rao (1954). Located on Bhogavo river. World's first artificial dockyard.",
    "Dholavira: Discovered by J.P. Joshi (1967). India's 40th UNESCO World Heritage site (2021).",
    "Water Wisdom: Dholavira is world-famous for its incredible reservoirs and storm-water management.",
    "Maritime Hub: Lothal served as the 'Manchester' of IVC, trading beads and textiles globally.",
    "City Planning: Dholavira is uniquely divided into 3 parts, while Lothal has 2 parts without a boundary wall."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Lothal: The Great Port City",
      "content": "Located near Gulf of Khambhat. Features a massive baked-brick dockyard. Proved trade with Mesopotamia via Persian Gulf seals. Famous for carnelian bead-making and double burials."
    },
    {
      "heading": "Dholavira: The Stone Metropolis",
      "content": "Located on Khadir Bet island. Extensively used stone (sandstone/limestone) unlike the mud-brick cities of Punjab/Sindh. Features a large 'Stadium' and a 10-letter Harappan signboard."
    },
    {
      "heading": "Comparison: Materials & Planning",
      "content": "Lothal was built with bricks and focused on commerce. Dholavira used stone and was likely a grand administrative center. Both show advanced navigational and water-conservation skills."
    }
  ];

  static const List<String> _keyFacts = [
    "Lothal means 'Mound of the Dead' in Gujarati.",
    "Dholavira is locally known as 'Kotada Timba'.",
    "Lothal yielded an ivory scale and shell compass.",
    "Dholavira's water system included interconnected reservoirs and dams.",
    "Rangpur was the first Harappan site excavated in Gujarat (1931).",
    "Surkotada provides evidence of horse bones."
  ];
}
