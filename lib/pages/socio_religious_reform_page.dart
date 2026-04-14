import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class SocioReligiousReformPage extends StatelessWidget {
  const SocioReligiousReformPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Socio-Religious Reforms',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Analysis of Reformers & Movements'),
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
                    title: 'Socio-Religious Reforms Quiz',
                    subject: 'History',
                    quizId: 'history_socio_reform_quiz',
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
    "Context: 19th-century awakening called the 'Indian Renaissance'.",
    "Brahmo Samaj: Founded by Raja Ram Mohan Roy (1828) to fight social evils.",
    "Arya Samaj: Founded by Swami Dayanand Saraswati (1875); 'Go back to the Vedas'.",
    "Ramakrishna Mission: Founded by Swami Vivekananda (1897) for spiritual/humanitarian service.",
    "Satyashodhak Samaj: Founded by Jyotiba Phule (1873) for lower-caste upliftment.",
    "Gujarat Reforms: Early bodies included Manav Dharma Sabha and Gujarat Vernacular Society."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Raja Ram Mohan Roy: The Pioneer",
      "content": "Abolished Sati in 1829. Emphasized monotheism and rationalism. Published 'Mirat-ul-Akbar' and founded Brahmo Samaj."
    },
    {
      "heading": "Dayanand & the Vedic Revival",
      "content": "Rejected idol worship and the birth-based caste system. Authored 'Satyarth Prakash'. Launched the 'Shuddhi Movement'."
    },
    {
      "heading": "Vivekananda's Global Impact",
      "content": "Represented India at the 1893 Chicago Parliament. Propagated 'Daridra Narayana'—serving the poor as divine worship."
    },
    {
      "heading": "Phule & the Anti-Caste Struggle",
      "content": "Authored 'Gulamgiri'. Opened first girl's school in 1848. Fought against Brahmanical domination via Satyashodhak Samaj."
    },
    {
      "heading": "Reformers of Gujarat",
      "content": "Durgaram Mehtaji (Manav Dharma Sabha), Kavi Narmad (Dandiyo), and A.K. Forbes (Gujarat Vernacular Society) pioneered modern thought."
    }
  ];

  static const List<String> _keyFacts = [
    "Widow Remarriage Act (1856): Passed due to Ishwar Chandra Vidyasagar's efforts.",
    "Title of 'Raja': Given to Ram Mohan Roy by Mughal Emperor Akbar II.",
    "Young Bengal Movement: Led by Henry Vivian Derozio for radical rationalism.",
    "Aligarh Movement: Sir Syed Ahmed Khan sought Western education for Muslims.",
    "Theosophical Society: Annie Besant made it popular; founded Central Hindu College.",
    "Sati Abolition: Achieved in 1829 under Lord William Bentinck."
  ];
}
