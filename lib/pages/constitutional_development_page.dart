import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class ConstitutionalDevelopmentPage extends StatelessWidget {
  const ConstitutionalDevelopmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Constitutional Development',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Analysis of British Acts'),
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
                    title: 'Constitutional Development Quiz',
                    subject: 'History',
                    quizId: 'history_constitutional_quiz',
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
    "Company Rule (1773-1858): From Regulating Act to the end of EIC after the 1857 Revolt.",
    "Crown Rule (1858-1947): Direct administration by the British monarch via the Secretary of State.",
    "1773 Act: First parliamentary step to control EIC; created Governor-General of Bengal.",
    "1833 Act: Peak of centralization; Governor-General of Bengal became Governor-General of India.",
    "1909 Act: Introduced separate electorates for Muslims, legalizing communalism.",
    "1935 Act: Most comprehensive Act; blueprint for the current Indian Constitution."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Early Centralization (1773-1853)",
      "content": "The Regulating Act (1773) established the Supreme Court. Pitt's India Act (1784) introduced 'Double Government'. The Charter Act of 1833 ended EIC's commercial role completely and made Lord William Bentinck the first GG of India."
    },
    {
      "heading": "Morley-Minto (1909) & Montagu-Chelmsford (1919)",
      "content": "The 1909 reforms introduced separate electorates. The 1919 Act introduced 'Dyarchy' in provinces (reserved vs transferred subjects) and a bicameral legislature at the Center."
    },
    {
      "heading": "Government of India Act 1935",
      "content": "Proposed an All-India Federation and Provincial Autonomy. It introduced Dyarchy at the Center, established the RBI and the Federal Court, and separated Burma from India."
    },
    {
      "heading": "The Portfolio System",
      "content": "Introduced by Lord Canning in 1859 and validated by the 1861 Act, it laid the foundation for modern cabinet-style administration in India."
    }
  ];

  static const List<String> _keyFacts = [
    "Warren Hastings: First Governor-General of Bengal (1773).",
    "Lord William Bentinck: First Governor-General of India (1833).",
    "Lord Canning: First Viceroy of India (1858).",
    "Lord Minto: Known as the 'Father of Communal Electorate'.",
    "Macaulay Committee (1854): Implemented open competition for Civil Services.",
    "Federal Court (1937): Established under the 1935 Act, predecessor to the Supreme Court."
  ];
}
