import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class VedicPeriodPage extends StatelessWidget {
  const VedicPeriodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Vedic Period',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Comparative Analysis'),
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
                    title: 'Vedic Period Quiz',
                    subject: 'History',
                    quizId: 'history_vedic_quiz',
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
    "Time Period: 1500 BC to 600 BC (Bronze Age to Iron Age).",
    "Divisions: Early Vedic Period (1500-1000 BC) and Later Vedic Period (1000-600 BC).",
    "Origin: Aryans entered India through the Northwest; Max Mueller's 'Central Asia Theory' is widely accepted.",
    "Geography: Early Aryans settled in the 'Sapta Sindhu' region (Land of Seven Rivers).",
    "Society: Pastoral and semi-nomadic in Early period; sedentary and agricultural in Later period.",
    "Polity: Tribal structure (Jana) with assemblies like Sabha, Samiti, Vidhata, and Gana."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Early Vedic vs. Later Vedic Society",
      "content": "Early Vedic society was patriarchal but egalitarian. Women occupied a high status, and the Varna system was based on profession, not birth. In the Later Vedic period, the Caste system (Varna) became hereditary and rigid. The concept of 'Gotra' appeared, and the status of women declined."
    },
    {
      "heading": "Religious Transformation",
      "content": "Early Vedic religion focused on personified forces of nature like Indra (Rain/War), Agni (Fire), and Varuna (Order). Sacrifices were simple. In the Later Vedic period, Prajapati (The Creator), Vishnu (The Preserver), and Rudra (The Destroyer) became prominent. Rituals became complex, expensive, and dominated by Brahmins."
    },
    {
      "heading": "Economy and Iron",
      "content": "Early Vedic economy was pastoral; cows were the most valued property (Gavisthi - search for cows). The Later Vedic period saw the 'Iron Revolution' (around 1000 BC), leading to extensive agriculture, forest clearing, and the rise of territorial kingdoms (Mahajanapadas)."
    }
  ];

  static const List<String> _keyFacts = [
    "Vedas: Four Vedas - Rigveda (Hymns), Samaveda (Music), Yajurveda (Rituals), Atharvaveda (Spells).",
    "Satyameva Jayate: Taken from the Mundaka Upanishad.",
    "Gayatri Mantra: Dedicated to Savitri (Solar deity), composed by Sage Vishwamitra.",
    "Vedanta: Refers to the Upanishads, the philosophical climax of the Vedas.",
    "Iron: Known as 'Shyama Ayas' (Black metal) in Later Vedic texts.",
    "Nishka: Originally a gold ornament, later used as a unit of currency."
  ];
}
