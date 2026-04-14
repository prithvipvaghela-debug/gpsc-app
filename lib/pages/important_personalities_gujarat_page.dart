import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class ImportantPersonalitiesGujaratPage extends StatelessWidget {
  const ImportantPersonalitiesGujaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Important Personalities',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Biographical Analysis', horizontalPadding: 0),
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
                    title: 'Personalities Quiz',
                    subject: 'History',
                    quizId: 'history_personalities_quiz',
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
    "Mahatma Gandhi (1869–1948): 'Father of the Nation'. Pioneer of Satyagraha and Ahimsa. Led India to independence.",
    "Sardar Vallabhbhai Patel (1875–1950): 'Iron Man of India'. First Deputy PM. Integrated 565 princely states.",
    "Dadabhai Naoroji (1825–1917): 'Grand Old Man of India'. Propounded the 'Drain of Wealth' theory.",
    "Morarji Desai (1896–1995): First non-Congress PM (1977). Received Bharat Ratna and Nishan-e-Pakistan.",
    "Dr. Vikram Sarabhai (1919–1971): 'Father of the Indian Space Program'. Founded PRL and setup ISRO."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Mahatma Gandhi: The Architect of Mass Awakening",
      "content": "Born in Porbandar, Gandhi transformed the INC into a mass organization. His tools of Satyagraha and Ahimsa mobilized millions. Authored 'Hind Swaraj' and 'My Experiments with Truth'. Edited journals like Harijan, Navjivan, and Young India."
    },
    {
      "heading": "Sardar Patel: The Unifier of India",
      "content": "Born in Nadiad, Patel was the organizational backbone of the INC. Championed the resolution on Fundamental Rights at Karachi (1931). Post-independence, he unified 565 princely states, earning the title 'Bismarck of India'."
    },
    {
      "heading": "Dadabhai Naoroji: The Economic Nationalist",
      "content": "Born in Navsari, Naoroji was a Moderate leader. First to analyze British economic exploitation in 'Poverty and Un-British Rule in India'. Served as INC President three times."
    },
    {
      "heading": "Morarji Desai: The Staunch Gandhian",
      "content": "Born in Valsad, Desai served as CM of Bombay and later PM. Passed the 44th Amendment to reverse Emergency excesses. Holds the record for presenting 10 Union Budgets."
    },
    {
      "heading": "Dr. Vikram Sarabhai: The Visionary Scientist",
      "content": "Pioneered space research and founded Physical Research Laboratory (PRL) in Ahmedabad (1947). Instrumental in establishing ISRO, ATIRA, and IIM Ahmedabad."
    },
    {
      "heading": "Gandhi vs Patel: Approaches",
      "content": "Gandhi was an idealist focusing on moral transformation and village republics. Patel was a realist and astute administrator focusing on party organization and state power."
    }
  ];

  static const List<String> _keyFacts = [
    "Rast Goftar: Newspaper founded by Dadabhai Naoroji in 1851.",
    "Statue of Unity: World's tallest statue dedicated to Sardar Patel.",
    "Nishan-e-Pakistan: Conferred upon Morarji Desai in 1990.",
    "Sabarmati Ashram: Shifted to the river banks by Gandhi in 1917.",
    "Cosmic Ray Research: Dr. Vikram Sarabhai's primary area under Sir C.V. Raman.",
    "First British MP: Dadabhai Naoroji (elected in 1892)."
  ];
}
