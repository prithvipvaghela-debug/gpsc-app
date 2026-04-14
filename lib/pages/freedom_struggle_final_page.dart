import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class FreedomStruggleFinalPage extends StatelessWidget {
  const FreedomStruggleFinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Final Phase (1942-1947)',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Analysis of the Final Phase'),
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
                    title: 'Final Phase Quiz',
                    subject: 'History',
                    quizId: 'history_final_phase_quiz',
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
    "Timeline: 1942-1947, a rapid period of constitutional plans and missions.",
    "Cripps Mission (1942): Offered Dominion Status after WWII; rejected as a 'post-dated cheque'.",
    "Cabinet Mission (1946): Rejected Pakistan; proposed a weak center and strong provincial groups.",
    "Direct Action Day: Called by Muslim League on Aug 16, 1946, leading to massive riots.",
    "Mountbatten Plan: June 3, 1947, formalized the partition of India into two dominions.",
    "Independence: British rule ended on August 15, 1947, via the Indian Independence Act."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Cripps Mission & Quit India",
      "content": "Sir Stafford Cripps failed to satisfy Indian demands for immediate power. This led to the Quit India Movement, the final mass uprising where Gandhi gave the 'Do or Die' call."
    },
    {
      "heading": "Cabinet Mission Proposals",
      "content": "Proposed a united India with provinces grouped into A, B, and C. While initially accepted for forming the Constituent Assembly, it later collapsed due to mistrust between INC and ML."
    },
    {
      "heading": "Mountbatten & Partition",
      "content": "Lord Mountbatten realized partition was inevitable to stop civil war. He speeded up the transfer of power. The Radcliffe Commission drew the new boundaries."
    },
    {
      "heading": "Indian Independence Act 1947",
      "content": "Enacted by British Parliament. Created India and Pakistan. Abolished Secretary of State and Viceroy offices. Lapsed British paramountcy over princely states."
    }
  ];

  static const List<String> _keyFacts = [
    "C.R. Formula (1944): Compromise plan by Rajagopalachari to resolve INC-ML deadlock.",
    "RIN Mutiny (1946): Naval ratings' rebellion in Bombay that shook British confidence.",
    "Interim Government: Formed in Sept 1946, headed by Jawaharlal Nehru.",
    "First Indian Governor-General: C. Rajagopalachari.",
    "Radcliffe Line: The boundary line between India and Pakistan.",
    "King George VI: The British monarch at the time of Indian independence."
  ];
}
