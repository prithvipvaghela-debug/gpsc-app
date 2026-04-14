import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class MughalEmpirePage extends StatelessWidget {
  const MughalEmpirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Mughal Empire',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Imperial Legacy', horizontalPadding: 0),
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
                    title: 'Mughal Empire Quiz',
                    subject: 'History',
                    quizId: 'history_mughal_quiz',
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
    "Time Period: 1526 AD to 1857 AD.",
    "Founder: Babur, after the First Battle of Panipat defeating Ibrahim Lodi.",
    "Great Mughals: Babur, Humayun, Akbar, Jahangir, Shah Jahan, Aurangzeb.",
    "Official Language: Persian was the language of court and administration.",
    "Administration: The Mansabdari System introduced by Akbar was the backbone.",
    "Architecture: Reached its zenith under Shah Jahan with the Taj Mahal."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Akbar's Greatness & Reforms",
      "content": "Akbar followed a policy of religious tolerance (Sulh-i-kul) and established 'Din-i-Ilahi'. He introduced the Mansabdari system for military and civil ranking. His revenue minister, Raja Todar Mal, implemented the 'Zabit' or 'Bandobast' system."
    },
    {
      "heading": "Architecture & Art",
      "content": "Shah Jahan is known as the 'Engineer King' for building the Taj Mahal, Red Fort, and Jama Masjid. Jahangir was a great patron of painting and installed the 'Chain of Justice' (Zanjir-i-Adil)."
    },
    {
      "heading": "Aurangzeb & Fragmentation",
      "content": "Aurangzeb was the last powerful Mughal. His reign saw the highest percentage of Hindu Mansabdars (33%) but was also marked by long Deccan wars and conflict with Marathas (Shivaji)."
    }
  ];

  static const List<String> _keyFacts = [
    "Baburnama: Autobiography of Babur written in Chagatai Turkic.",
    "Ain-i-Akbari: Detailed administrative account written by Abul Fazl.",
    "Pietra Dura: Peak architectural inlay style used in the Taj Mahal.",
    "Nur Jahan: The powerful empress who co-ruled with Jahangir.",
    "Babur's Tomb: Located in Kabul, Afghanistan, as per his wishes.",
    "2nd Battle of Panipat: 1556 AD, Akbar's forces (Bairam Khan) defeated Hemu."
  ];
}
