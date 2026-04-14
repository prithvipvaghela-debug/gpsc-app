import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class MedievalGujaratPage extends StatelessWidget {
  const MedievalGujaratPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Medieval Gujarat',
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
                    title: 'Medieval Gujarat Quiz',
                    subject: 'History',
                    quizId: 'history_medieval_gujarat_quiz',
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
    "Golden Age: Solanki period (942-1244 AD) is the pinnacle of Gujarat's cultural and economic growth.",
    "Capital: Anhilwad Patan served as the majestic center for Chavdas and Solankis.",
    "Siddharaj Jaysinh: Greatest Solanki ruler, earned the title 'Avanthinath' and patronized Hemchandracharya.",
    "Kumarpal: The 'Ashoka of Gujarat', promoted Jainism and reconstructed Somnath temple in stone.",
    "Gujarat Sultanate: Founded by Zafar Khan (1407 AD). Ahmed Shah I founded Ahmedabad in 1411 AD.",
    "Indo-Islamic Style: A unique architectural fusion of Hindu/Jain carvings with Islamic structural forms."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Solanki Glory & Architecture",
      "content": "Known for the Maru-Gurjara style. Bhima I built the Modhera Sun Temple. Queen Udayamati built Rani Ki Vav. Rudra Mahalaya and Sahastralinga Talav represent the era's grand engineering."
    },
    {
      "heading": "The Rise of Ahmedabad",
      "content": "Ahmed Shah I shifted the capital from Patan. Advised by saint Sheikh Ahmad Khattu, he established the city on the Sabarmati. Introduced the 'Vanta' system for land administration."
    },
    {
      "heading": "Cultural & Scholarly Contributions",
      "content": "Hemchandracharya (Changdev) wrote 'Siddha Hema Shabdanushasana'. Kumarpal enforced strict Ahimsa. Naikidevi's victory over Muhammad Ghori (1178 AD) saved Gujarat from early invasion."
    },
    {
      "heading": "Maritime Power",
      "content": "Gujarat's ports like Khambhat and Bharuch were vital international trade hubs. The Sultanate maintained a strong navy to challenge emerging Portuguese influence."
    }
  ];

  static const List<String> _keyFacts = [
    "1024 AD: Mahmud Ghazni's devastating attack on Somnath during Bhima I's reign.",
    "UNESCO Sites: Rani Ki Vav (Solanki) and Ahmedabad Heritage City (Sultanate).",
    "Mustafabad: The new name for Junagadh after its conquest by Mahmud Begada.",
    "Tree of Life: The famous Jali screen in Sidi Saiyyed Mosque, Ahmedabad.",
    "Vaghela Dynasty: The last Hindu dynasty before the Delhi Sultanate's conquest in 1299 AD.",
    "Tejpal & Vastupal: Ministers who built the Dilwara Jain Temples at Mount Abu."
  ];
}
