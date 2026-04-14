import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class PostMauryaPeriodPage extends StatelessWidget {
  const PostMauryaPeriodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Post-Maurya Period',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Political & Cultural Analysis'),
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
                    title: 'Post-Maurya Quiz',
                    subject: 'History',
                    quizId: 'history_post_maurya_quiz',
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
    "Time Period: ~185 BCE to 300 CE. Era of political fragmentation.",
    "Native Successors: Shungas, Kanvas, Satavahanas (Deccan), Chedis (Kalinga).",
    "Foreign Invaders: Indo-Greeks, Shakas, Parthians, Kushanas (I-S-P-K).",
    "Economic Prosperity: Silk Route control and thriving trade with the Roman Empire.",
    "Religious Evolution: Rise of Mahayana Buddhism and revival of Brahmanism.",
    "Art Schools: Emergence of Gandhara (Greco-Roman) and Mathura (Indigenous) schools."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "The Kushana Empire & Kanishka",
      "content": "Greatest Kushana ruler who started the Shaka Era (78 CE). Controlled the Silk Route and patronized the 4th Buddhist Council in Kashmir. Issued the purest gold coins."
    },
    {
      "heading": "The Satavahanas (Andhras)",
      "content": "Ruled the Deccan. Greatest ruler: Gautamiputra Satakarni. Known for matronymics, land grants to Brahmins, and issuing Lead coins."
    },
    {
      "heading": "Shaka Rule & Rudradaman I",
      "content": "The Western Kshatrapas were prominent in Gujarat. Rudradaman I is famous for repairing Sudarshana Lake and issuing the first long Sanskrit inscription at Junagadh."
    },
    {
      "heading": "Gandhara vs. Mathura Art",
      "content": "Gandhara: Muscular Buddha, Greek influence, bluish schist stone. Mathura: Spiritual Buddha, spotted red sandstone, purely indigenous style."
    }
  ];

  static const List<String> _keyFacts = [
    "Milindapanho: Dialogue between Menander (Indo-Greek) and Nagasena.",
    "Ashvaghosha: Court poet of Kanishka, wrote 'Buddhacharita'.",
    "Charaka: Father of Indian Ayurveda, served in Kanishka's court.",
    "St. Thomas: Believed to have visited India during the Parthian King Gondophernes' reign.",
    "Nishka: Originally a gold ornament, used as currency.",
    "Patanjali: Author of Mahabhashya, contemporary of Pushyamitra Shunga."
  ];
}
