import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class RegionalGujaratPage extends StatelessWidget {
  const RegionalGujaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Regional Kingdoms (Gujarat)',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Dynastic & Cultural Analysis', horizontalPadding: 0),
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
                    title: 'Regional Gujarat Quiz',
                    subject: 'History',
                    quizId: 'history_regional_gujarat_quiz',
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
    "Golden Age: Solanki period (942–1244 AD) is the pinnacle of Gujarat's medieval history.",
    "Solanki Capital: Anhilwad Patan served as the majestic capital.",
    "Last Hindu Rule: Vaghela dynasty followed the Solankis until 1299 AD.",
    "Ahmedabad: Founded by Ahmed Shah I in 1411 AD on the Sabarmati banks.",
    "Mahmud Begada: Greatest Gujarat Sultan, conquered Girnar and Pavagadh forts.",
    "Architecture: Unique blend of Hindu/Jain and Islamic styles (Indo-Islamic)."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Solanki Glory: Siddharaj & Kumarpal",
      "content": "Siddharaj Jaisinh was the greatest Solanki king who patronized Hemchandracharya. Kumarpal, the 'Ashoka of Gujarat', embraced Jainism and banned animal slaughter."
    },
    {
      "heading": "Architectural Marvels",
      "content": "Modhera Sun Temple (Bhima I), Rani Ki Vav (Queen Udayamati), and Sahastralinga Talav represent the zenith of Solanki art. The Sultanate era contributed the Sidi Saiyyed Ni Jali and Adalaj Vav."
    },
    {
      "heading": "Foundation of Ahmedabad",
      "content": "Ahmed Shah I shifted the capital from Patan. He established the Bhadra Fort and introduced the Vanta land system to stabilize his rule."
    },
    {
      "heading": "Maritime Power & Portuguese Conflict",
      "content": "Gujarat had a strong navy under Mahmud Begada. Sultan Bahadur Shah's treacherous drowning by the Portuguese in 1537 marked a turning point in maritime history."
    }
  ];

  static const List<String> _keyFacts = [
    "Battle of Kasahrada: Queen Naikidevi defeated Muhammad Ghori in 1178 AD.",
    "UNESCO Sites: Rani Ki Vav and Champaner-Pavagadh Archaeological Park.",
    "Hemchandracharya: Authored the grammar work 'Siddha Hema Shabdanushasana'.",
    "Somnath: Looted by Mahmud Ghazni in 1024 AD during Bhima I's reign.",
    "Sidi Saiyyed Jali: Famous for the 'Tree of Life' motif in Ahmedabad.",
    "Mustafabad: The name given to Junagadh by Mahmud Begada after its conquest."
  ];
}
