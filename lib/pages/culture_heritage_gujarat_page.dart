import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class CultureHeritageGujaratPage extends StatelessWidget {
  const CultureHeritageGujaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Culture & Heritage',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Cultural Analysis', horizontalPadding: 0),
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
                    title: 'Culture & Heritage Quiz',
                    subject: 'History',
                    quizId: 'history_culture_quiz',
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
    "UNESCO Sites: Champaner (2004), Rani ki Vav (2014), Ahmedabad City (2017), Dholavira (2021).",
    "UNESCO Intangible: 'Garba' of Gujarat was inscribed in December 2023.",
    "Major Fairs: Tarnetar (Matchmaking), Vautha (Animal trade), Bhavnath (Naga Sadhus).",
    "Architecture: Renowned for the Maru-Gurjara style and Indo-Islamic fusion.",
    "Dance: Navratri is the world's longest dance festival focusing on Shakti worship.",
    "Handicrafts: Patola (Double Ikat), Rogan art, Bandhani, and Sankheda furniture."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Festivals & Dance Forms",
      "content": "Navratri honors Goddess Shakti with Garba and Dandiya Raas. Garba symbolizes life and the womb (Garbha Deep). Uttarayan is the International Kite Festival. Rann Utsav celebrates the desert culture of Kutch."
    },
    {
      "heading": "Temple Architecture (Maru-Gurjara)",
      "content": "Characterized by intricate stone carvings. Modhera Sun Temple (1026 AD) is a prime example. Palitana on Shatrunjaya hills houses over 900 Jain temples."
    },
    {
      "heading": "Rani ki Vav (Queen's Stepwell)",
      "content": "Built by Queen Udayamati in Patan. Designed as an inverted temple with seven levels and 500+ sculptures, mostly of Dashavatara (Vishnu's incarnations)."
    },
    {
      "heading": "Exquisite Textiles & Crafts",
      "content": "Patola of Patan is a rare double-ikat silk. Rogan Art (Kutch) uses castor oil. Sankheda (Chhota Udepur) is famous for lacquered teak furniture. Pithora is ritualistic tribal wall art."
    }
  ];

  static const List<String> _keyFacts = [
    "Bhavai: Traditional folk theatre founded by Asait Thakar in the 14th century.",
    "Vautha Fair: Largest animal fair in Gujarat, famous for donkey trading.",
    "Madhavpur Mela: Celebrates the marriage of Lord Krishna and Rukmini.",
    "Ajarakh: Unique block printing art of Kutch using natural dyes.",
    "Kutchi Embroidery: Famous for vibrant colors and mirror work (Aabhla).",
    "Mata Ni Pachedi: Traditional textile shrine art of the Vaghari community."
  ];
}
