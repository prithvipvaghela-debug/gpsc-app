import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class BhaktiSufiMovementPage extends StatelessWidget {
  const BhaktiSufiMovementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Bhakti & Sufi Movement',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Devotional Analysis', horizontalPadding: 0),
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
                    title: 'Bhakti & Sufi Quiz',
                    subject: 'History',
                    quizId: 'history_bhakti_sufi_quiz',
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
    "Origin: Started in South India (Alvars & Nayanars), later spreading to the North.",
    "Core Idea: Salvation through intense devotion (Bhakti) and personal experience of God.",
    "Schools: Nirguna (formless God, e.g., Kabir) and Saguna (God with form, e.g., Mirabai).",
    "Sufism: Islamic mysticism emphasizing divine love and rejecting orthodoxy.",
    "Sufi Orders: Chishti, Suhrawardi, Qadiri, and Naqshbandi are prominent silsilas.",
    "Impact: Growth of regional languages and literature; promoted social equality."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Alvars and Nayanars",
      "content": "12 Alvars (devotees of Vishnu) and 63 Nayanars (devotees of Shiva) in Tamil Nadu. Andal was the only female Alvar. Their compositions like Tevaram are highly revered."
    },
    {
      "heading": "Bhakti Saints & Gujarat Connection",
      "content": "Narsinh Mehta, the 'Adi Kavi' of Gujarat, wrote 'Vaishnav Jan To'. Mirabai spent her later years in Dwarka. Ramananda brought the movement to North India."
    },
    {
      "heading": "The Sufi Silsilas",
      "content": "Chishti order (Moinuddin Chishti) focused on poverty and simple living. Nizamuddin Auliya was a famous saint. Suhrawardi order accepted state patronage."
    },
    {
      "heading": "Philosophies of the Era",
      "content": "Adi Shankaracharya (Advaita - Non-dualism) and Ramanujacharya (Vishishtadvaita - Qualified non-dualism) provided the intellectual foundation."
    }
  ];

  static const List<String> _keyFacts = [
    "Khanqah: Sufi hospice or gathering place.",
    "Sama: Sufi musical gatherings (origin of Qawwali).",
    "Bijak: Collection of Kabir's verses and teachings.",
    "Tripitaka: Rules and teachings of Buddhism (comparison context).",
    "Valabhi Council: 2nd Jain Council held in Gujarat (comparison context).",
    "Adi Kavi: Narsinh Mehta of Gujarat."
  ];
}
