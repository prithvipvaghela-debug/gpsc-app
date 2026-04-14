import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class VijayanagarBahmaniPage extends StatelessWidget {
  const VijayanagarBahmaniPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Vijayanagar & Bahmani',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes', horizontalPadding: 0),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Comparative & Administrative Analysis', horizontalPadding: 0),
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
                    title: 'Vijayanagar & Bahmani Quiz',
                    subject: 'History',
                    quizId: 'history_vijayanagar_bahmani_quiz',
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
    "Vijayanagar: Founded 1336 AD by Harihara & Bukka (Sangama) on Tungabhadra river.",
    "Bahmani: Founded 1347 AD by Alauddin Hasan Bahman Shah (Hasan Gangu).",
    "Raichur Doab: Fertile land between Krishna & Tungabhadra, the main cause of conflict.",
    "Battle of Talikota (1565): Coalition of Deccan Sultanates destroyed Vijayanagar (Hampi).",
    "Dynasties (Vijayanagar): Sangama ➔ Saluva ➔ Tuluva ➔ Aravidu.",
    "Greatest Ruler: Krishnadevaraya (Tuluva dynasty), author of 'Amuktamalyada'."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Krishnadevaraya's Golden Era",
      "content": "Known as 'Andhra Bhoja'. Patronized the 'Ashtadiggajas' (8 great Telugu poets). Built Vittalaswami temple. Maintained strong ties with Portuguese for Arabian horses."
    },
    {
      "heading": "Nayankara & Ayagar Systems",
      "content": "Nayankara: Military land grants (Amaram) to chiefs (Nayakas). Ayagar: 12 village functionaries managing local administration with tax-free lands."
    },
    {
      "heading": "The Bahmani Sultanate & Mahmud Gawan",
      "content": "Mahmud Gawan was a brilliant PM who expanded the kingdom and built a great Madrasa at Bidar. Internal strife (Deccanis vs. Afaqis) weakened the state."
    },
    {
      "heading": "Architecture & Coins",
      "content": "Vijayanagar: Tall Rayagopurams and musical pillars. Bahmani: Synthesis of Persian and local styles (e.g., Gol Gumbaz). Gold coin 'Varaha' (Vijayanagar) was widely used."
    }
  ];

  static const List<String> _keyFacts = [
    "Hampi: UNESCO World Heritage site and former capital of Vijayanagar.",
    "Abdur Razzaq: Persian traveler who marveled at Vijayanagar's splendor.",
    "Madhura Vijayam: Sanskrit work by Gangadevi on Madurai's conquest.",
    "Gajabetegara: Title of Devaraya II (The Elephant Hunter).",
    "Talikota: Also known as Rakshasi-Tangadi, marking the end of Vijayanagar's glory.",
    "Bidar Madrasa: Famous institution of learning built by Mahmud Gawan."
  ];
}
