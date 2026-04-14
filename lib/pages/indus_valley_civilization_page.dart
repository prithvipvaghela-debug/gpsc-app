import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import 'dynamic_mcq_page.dart';

class IndusValleyCivilizationPage extends StatelessWidget {
  const IndusValleyCivilizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Indus Valley Civilization',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionTitle(title: 'Quick Notes'),
          const SizedBox(height: 12),
          ..._quickNotes.map((note) => _buildBulletPoint(context, note)),
          const SizedBox(height: 24),
          
          const SectionTitle(title: 'Detailed Analysis'),
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
                    title: 'IVC Topic Quiz',
                    subject: 'History',
                    quizId: 'history_ivc_quiz',
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
    "Time Period: 2500 BC to 1750 BC (determined by Carbon-14 dating).",
    "Era: Belongs to the Bronze Age (Chalcolithic Period).",
    "Nomenclature: John Marshall was the first scholar to use the term 'Indus Civilization'.",
    "First Discoveries: Harappa discovered by Dayaram Sahni (1921); Mohenjo-Daro by R.D. Banerjee (1922).",
    "Key Feature: First urban civilization of South Asia, highly renowned for its grid-system town planning and drainage.",
    "Major Gujarat Sites: Dholavira, Lothal, Surkotada, Rangpur, and Rojdi."
  ];

  static const List<Map<String, String>> _deepNotes = [
    {
      "heading": "Town Planning & Architecture",
      "content": "Cities were generally divided into two parts: the raised Citadel (western part, for elite and public buildings) and the Lower Town (eastern part, for commoners). Houses were built with standardized burnt bricks. They featured an advanced underground drainage system with manholes. Streets intersected at right angles (grid pattern)."
    },
    {
      "heading": "Economy & Agriculture",
      "content": "The Harappans were the earliest people to produce cotton. Major crops included wheat, barley, mustard, and sesame. Trade was highly developed without metallic money (barter system prevailed). There is strong evidence of trade with Mesopotamia, where the Indus region was referred to as 'Meluhha'."
    },
    {
      "heading": "Society & Religion",
      "content": "Society was largely egalitarian and peaceful, with very few weapons found. The chief male deity was 'Pashupati Mahadeva' (Proto-Shiva), depicted on seals surrounded by an elephant, tiger, rhino, and buffalo, with deer at his feet. The chief female deity was the Mother Goddess. No structural temples have been discovered."
    },
    {
      "heading": "Gujarat's Significance (Highly Important for GPSC)",
      "content": "Gujarat is home to crucial IVC sites. Rangpur (Surendranagar) was the first site excavated in Gujarat (1931). Lothal (Ahmedabad), situated on the Bhogavo river, was a major port with an artificial brick dockyard, bead-making factories, and evidence of double burials. Dholavira (Kutch) is unique for being divided into three parts, having a spectacular water-harvesting system, and a 10-letter signboard. Surkotada (Kutch) provides rare evidence of horse bones."
    }
  ];

  static const List<String> _keyFacts = [
    "Script: Boustrophedon (written right-to-left, then left-to-right). It is pictographic and remains undeciphered.",
    "Metals Known: Copper, Bronze, Silver, Gold. (Iron was NOT known).",
    "Standardized Weights: Based on multiples of 16 (16, 64, 160, etc.).",
    "Seals: The most beautiful works of IVC art, primarily made of Steatite (soapstone).",
    "Dholavira: Declared India's 40th UNESCO World Heritage Site in 2021.",
    "Mohenjo-Daro translates to 'Mound of the Dead' in Sindhi."
  ];
}
