import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class MahajanapadasPage extends StatelessWidget {
  const MahajanapadasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Mahajanapadas',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Political & Strategic Analysis'),
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
                    title: 'Mahajanapadas Quiz',
                    subject: 'History',
                    quizId: 'history_mahajanapadas_quiz',
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
    "Time Period: 6th Century BCE (era of Second Urbanization in India).",
    "Primary Sources: Buddhist 'Anguttara Nikaya' and Jain 'Bhagavati Sutra' list 16 Mahajanapadas.",
    "Major Catalyst: Widespread use of Iron in agriculture and weaponry led to surplus production.",
    "Shift in Loyalty: Allegiance shifted from the 'Jana' (tribe) to the 'Janapada' (territory).",
    "Types of Government: Divided into Monarchies (Rajya) and Republics (Ganas/Sanghas).",
    "The Big Four: Magadha, Kosala, Avanti, and Vatsa emerged as the most powerful."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Transition from Tribes to Kingdoms",
      "content": "During the Later Vedic period, tribal units (Janas) began settling down in specific territories, becoming 'Janapadas'. By the 6th century BCE, the use of iron tools cleared the dense forests of the Gangetic plains, leading to an agricultural surplus. Stronger Janapadas conquered weaker ones, transforming into 'Mahajanapadas' (Great Kingdoms)."
    },
    {
      "heading": "Political Structure",
      "content": "1. Monarchies (Rajya): Centralized power under a king (Rajan). Examples: Magadha, Kosala, Vatsa, Avanti.\n2. Republics (Ganas or Sanghas): Ruled by a council of elders. Decisions made through voting. Examples: Vajji (Vaishali), Malla."
    },
    {
      "heading": "The 16 Mahajanapadas (List & Capitals)",
      "content": "Kasi (Varanasi), Kosala (Shravasti), Anga (Champa), Magadha (Rajagriha/Pataliputra), Vajji (Vaishali), Malla (Kushinagar), Chedi (Shuktivati), Vatsa (Kaushambi), Kuru (Indraprastha), Panchala (Ahichhatra), Matsya (Viratanagara), Surasena (Mathura), Asmaka (Potali - only one in South India), Avanti (Ujjain), Gandhara (Taxila), Kamboja (Rajapur)."
    },
    {
      "heading": "The Rise of Magadha",
      "content": "Magadha's success was due to strategic capitals (Rajagriha, Pataliputra), rich iron ore deposits, timber and elephants from dense forests, and a fertile agricultural base in the Gangetic plains."
    }
  ];

  static const List<String> _keyFacts = [
    "Second Urbanization: Refers to the Ganga valley development in the 6th Century BCE.",
    "Taxila (Gandhara): Renowned ancient center of education and trade.",
    "Punch-marked Coins: First metallic money in India, mostly silver (Karshapana).",
    "Asmaka/Assaka: The only Mahajanapada situated south of the Vindhyas (Godavari river).",
    "Ujjain (Avanti): Vital transit hub for the Dakshinapatha trade route.",
    "Vaishali (Vajji): Considered the first and oldest republic in the world."
  ];
}
