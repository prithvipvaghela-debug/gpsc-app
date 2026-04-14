import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class Revolt1857Page extends StatelessWidget {
  const Revolt1857Page({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Revolt of 1857',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Analysis of the Uprising', horizontalPadding: 0),
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
                    title: 'Revolt of 1857 Quiz',
                    subject: 'History',
                    quizId: 'history_revolt_1857_quiz',
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
    "Origin: Started on 10th May 1857 at Meerut cantonment.",
    "Immediate Cause: Enfield rifle cartridges rumored to be greased with cow/pig fat.",
    "Governor-General: Lord Canning (who also became the first Viceroy).",
    "Symbol: Lotus flower and Chapati (Bread) passed between villages.",
    "Outcome: EIC rule ended; power transferred directly to the British Crown.",
    "Result: Government of India Act 1858 and Queen Victoria's Proclamation."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Political & Economic Causes",
      "content": "Doctrine of Lapse (Satara, Jhansi, Nagpur) and the 1856 annexation of Awadh angered the nobility. High land taxes and destruction of handicrafts ruined peasants and artisans."
    },
    {
      "heading": "Key Centers & Leaders",
      "content": "Delhi (Bahadur Shah Zafar), Kanpur (Nana Saheb & Tantia Tope), Lucknow (Begum Hazrat Mahal), Jhansi (Rani Lakshmibai), and Bihar (Kunwar Singh)."
    },
    {
      "heading": "Military & Religious Factors",
      "content": "Discrimination against Indian sepoys and the General Service Enlistment Act (overseas service). The Lex Loci Act allowing Christian converts to inherit property offended orthodox sentiments."
    },
    {
      "heading": "Failure & Failure Reasons",
      "content": "Localized nature (mostly North/Central India), lack of unified vision, and active support of British by some Indian rulers like Scindias and Holkars."
    }
  ];

  static const List<String> _keyFacts = [
    "Mangal Pandey: 34th Bengal Native Infantry, triggered the spark at Barrackpore.",
    "V.D. Savarkar: First called it the 'First War of Independence' in his 1909 book.",
    "Sir Hugh Rose: British general who fought Rani Lakshmibai at Jhansi.",
    "Garbadas Patel: Led the 1857 uprising in Anand (Gujarat).",
    "Jodha & Mulu Manek: Led the Wagher rebellion in Okhamandal (Gujarat).",
    "Peel Commission: Appointed to reorganize the Indian army after the revolt."
  ];
}
