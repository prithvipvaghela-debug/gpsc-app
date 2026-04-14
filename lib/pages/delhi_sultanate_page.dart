import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class DelhiSultanatePage extends StatelessWidget {
  const DelhiSultanatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Delhi Sultanate',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Dynastic & Strategic Analysis', horizontalPadding: 0),
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
                    title: 'Delhi Sultanate Quiz',
                    subject: 'History',
                    quizId: 'history_delhi_sultanate_quiz',
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
    "Time Period: 1206 AD to 1526 AD.",
    "Five Dynasties: Slave, Khilji, Tughlaq, Sayyid, and Lodi (S-K-T-S-L).",
    "Origin: Founded by Qutb-ud-din Aibak, trusted general of Muhammad Ghori.",
    "Language: Persian was the official administrative and court language.",
    "Duration: Tughlaqs ruled for the longest period; Khiljis for the shortest.",
    "End: Concluded with Babur's victory over Ibrahim Lodi at the 1st Battle of Panipat."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Slave & Khilji Dynasties",
      "content": "Iltutmish (Slave) is the real founder who introduced the Iqta system. Alauddin Khilji (Khilji) is famous for Market Control Reforms and the conquest of Gujarat (1299 AD), defeating Karna Deva II."
    },
    {
      "heading": "The Tughlaqs & Experiments",
      "content": "Muhammad bin Tughlaq is known for shifting the capital to Daulatabad and introducing Token Currency. Firoz Shah Tughlaq focused on public works and massive irrigation canals."
    },
    {
      "heading": "The Lodi Dynasty (Afghan Rule)",
      "content": "Founded by Bahlul Lodi. Sikandar Lodi founded Agra (1504 AD). The era ended with Ibrahim Lodi's defeat in 1526 AD."
    },
    {
      "heading": "Central Administration",
      "content": "Absolute monarchy with departments like Diwan-i-Wizarat (Finance), Diwan-i-Arz (Military), and Diwan-i-Insha (Correspondence)."
    }
  ];

  static const List<String> _keyFacts = [
    "Amir Khusrau: 'Tuti-e-Hind', patronized by Alauddin Khilji, invented Sitar and Tabla.",
    "Ibn Battuta: Moroccan traveler who visited during Muhammad bin Tughlaq's reign.",
    "Qutub Minar: Started by Aibak, completed by Iltutmish.",
    "Blood and Iron: Policy adopted by Balban to centralize power.",
    "Lakh Bakhsh: Title of Qutb-ud-din Aibak due to his generosity.",
    "Gaj-i-Sikandari: Measurement yardstick introduced by Sikandar Lodi."
  ];
}
