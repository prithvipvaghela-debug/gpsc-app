import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class BritishRuleGujaratPage extends StatelessWidget {
  const BritishRuleGujaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'British Rule in Gujarat',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Administrative & Economic Analysis', horizontalPadding: 0),
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
                    title: 'British Rule Gujarat Quiz',
                    subject: 'History',
                    quizId: 'history_british_rule_gujarat_quiz',
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
    "Initial Entry: First EIC factory established in Surat in 1613.",
    "Political Control: Annexation of Surat (1800) and Treaty of Bassein (1802).",
    "End of Marathas: Peshwa's territories in Gujarat annexed by British in 1818.",
    "Administrative Mix: Divided into directly ruled 'British Gujarat' and Princely States.",
    "Industrialization: First textile mill in Ahmedabad (1861) by Ranchhodlal Chhotalal.",
    "Cotton Boom: Triggered by the American Civil War (1861-1865)."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Direct vs. Indirect Rule",
      "content": "British Gujarat (Ahmedabad, Kheda, Surat, etc.) was under the Bombay Presidency. Hundreds of other states were managed via 'Agencies' using Political Agents."
    },
    {
      "heading": "Economic Transformation",
      "content": "Introduction of the Ryotwari system bypassed traditional intermediaries. Heavy focus on cash crops like cotton and tobacco led to vulnerability during famines like Chhappaniyo Dukal."
    },
    {
      "heading": "The Manchester of India",
      "content": "Gujarati entrepreneurs used mercantile capital to build modern mills. Ahmedabad's rapid industrialization earned it this global title by the early 20th century."
    },
    {
      "heading": "Resistance & Uprisings",
      "content": "Included the fierce Wagher Rebellion in Okhamandal (1858) and the Naikda tribal revolt in Panch Mahals (1868) against British forest and revenue laws."
    }
  ];

  static const List<String> _keyFacts = [
    "First Railway: Opened between Utran and Ankleshwar in 1860.",
    "Walker Settlements (1807): Consolidated British indirect rule in Kathiawar.",
    "Gujarat Vernacular Society: Founded in 1848 by A.K. Forbes and Dalpatram.",
    "Hope Bridge: Built across the Tapi river in Surat in 1877.",
    "Sayajirao Gaekwad III: The most progressive and modernizing ruler of Baroda state.",
    "Garbadas Patel: Led a localized rebellion in Anand during the 1857 Revolt."
  ];
}
