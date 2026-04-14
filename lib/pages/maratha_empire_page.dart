import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class MarathaEmpirePage extends StatelessWidget {
  const MarathaEmpirePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Maratha Empire',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Military & Administrative Analysis', horizontalPadding: 0),
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
                    title: 'Maratha Empire Quiz',
                    subject: 'History',
                    quizId: 'history_maratha_quiz',
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
    "Founder: Chhatrapati Shivaji Maharaj (1630–1680).",
    "Military Strategy: 'Ganimi Kava' (Guerrilla Warfare) in the Sahyadri mountains.",
    "Administration: Guided by the 'Ashtapradhan' (Council of 8 Ministers).",
    "Revenue: Primarily based on Chauth (25% tax) and Sardeshmukhi (10% tax).",
    "Peshwa Era: 18th century shift of power to the Prime Ministers (Peshwas).",
    "Major Tragedies: The Third Battle of Panipat (1761) against Ahmad Shah Abdali."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Shivaji Maharaj's Rise & Tactics",
      "content": "Born at Shivneri, Shivaji successfully challenged the Adilshahi and Mughal empires. He famously escaped from Aurangzeb's captivity in Agra and was crowned at Raigad in 1674."
    },
    {
      "heading": "The Ashtapradhan System",
      "content": "Council of 8 ministers: Peshwa (PM), Amatya (Finance), Sachiv (Secretary), Sumant (Foreign), Senapati (Military), Mantri (Intelligence), Nyayadhish (Justice), and Panditrao (Religion)."
    },
    {
      "heading": "Expansion under the Peshwas",
      "content": "Baji Rao I was the greatest cavalry general who expanded into North India. Balaji Baji Rao (Nana Saheb) saw the empire reach its maximum territorial extent before 1761."
    },
    {
      "heading": "Economic & Military Structure",
      "content": "Abolished Jagirdari; paid soldiers in cash. Forts were the backbone, managed by Havaldar, Sabnis, and Karkhanis to ensure loyalty."
    }
  ];

  static const List<String> _keyFacts = [
    "Surat: Shivaji looted this wealthy Mughal port twice (1664 and 1670).",
    "Gaekwads: Maratha dynasty that ruled Gujarat with Vadodara as the capital.",
    "Baji Rao I: Fought 41 battles and never lost a single one.",
    "Treaty of Purandar: Signed in 1665 between Shivaji and Mirza Raja Jai Singh.",
    "Bargirs & Silahdars: Two types of Maratha cavalrymen.",
    "Panipat (1761): Decided that the Marathas would not rule all of India."
  ];
}
