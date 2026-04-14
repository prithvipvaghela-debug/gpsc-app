import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import '../widgets/section_title.dart';
import 'advent_of_europeans_page.dart';
import 'british_rule_gujarat_page.dart';
import 'culture_heritage_gujarat_page.dart';
import 'freedom_movement_gujarat_page.dart';
import 'important_personalities_gujarat_page.dart';
import 'british_expansion_page.dart';
import 'revolt_1857_page.dart';
import 'revolutionary_movements_page.dart';
import 'socio_religious_reform_page.dart';
import 'bhakti_sufi_movement_page.dart';
import 'constitutional_development_page.dart';
import 'freedom_struggle_final_page.dart';
import 'gandhian_era_page.dart';
import 'delhi_sultanate_page.dart';
import 'gupta_empire_page.dart';
import 'inc_early_phase_page.dart';
import 'indus_valley_civilization_page.dart';
import 'lothal_dholavira_page.dart';
import 'mahajanapadas_page.dart';
import 'maratha_empire_page.dart';
import 'maurya_empire_page.dart';
import 'medieval_gujarat_page.dart';
import 'mughal_empire_page.dart';
import 'post_maurya_period_page.dart';
import 'regional_gujarat_page.dart';
import 'religion_philosophy_page.dart';
import 'vedic_period_page.dart';
import 'vijayanagar_bahmani_page.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'History',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SectionTitle(
            title: 'Ancient History',
            subtitle: 'Explore the foundations of Indian civilization.',
          ),
          SectionItemCard(
            title: 'Indus Valley Civilization',
            subtitle: 'The first urban civilization of South Asia.',
            icon: Icons.foundation_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const IndusValleyCivilizationPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Ancient Gujarat (Lothal & Dholavira)',
            subtitle: 'Harappan heritage and maritime glory of Gujarat.',
            icon: Icons.anchor_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LothalDholaviraPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Vedic Period',
            subtitle: 'Early and Later Vedic periods and core texts.',
            icon: Icons.menu_book_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VedicPeriodPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Mahajanapadas',
            subtitle: 'The 16 great kingdoms and rise of territorial states.',
            icon: Icons.castle_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MahajanapadasPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Maurya Empire',
            subtitle: 'The first pan-Indian empire and Ashoka the Great.',
            icon: Icons.account_balance_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MauryaEmpirePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Post-Maurya Period',
            subtitle: 'Foreign invasions and native successors.',
            icon: Icons.temple_hindu_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostMauryaPeriodPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Gupta Empire',
            subtitle: 'The Golden Age of ancient India.',
            icon: Icons.auto_awesome_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GuptaEmpirePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Religion & Philosophy',
            subtitle: 'Rise of Buddhism and Jainism.',
            icon: Icons.psychology_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReligionPhilosophyPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Medieval History',
            subtitle: 'Dynasties, culture, and transformations.',
          ),
          SectionItemCard(
            title: 'Delhi Sultanate',
            subtitle: 'Five dynasties from Slave to Lodi.',
            icon: Icons.mosque_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DelhiSultanatePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Mughal Empire',
            subtitle: 'Golden Age of architecture and empire.',
            icon: Icons.architecture_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MughalEmpirePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Maratha Empire',
            subtitle: 'Rise of Shivaji Maharaj and guerrilla warfare.',
            icon: Icons.shield_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarathaEmpirePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Bhakti & Sufi Movement',
            subtitle: 'Devotional movements and mystic traditions.',
            icon: Icons.library_music_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BhaktiSufiMovementPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Vijayanagar & Bahmani',
            subtitle: 'Glory of South Indian medieval kingdoms.',
            icon: Icons.castle_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VijayanagarBahmaniPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Regional Kingdoms (Gujarat)',
            subtitle: 'Solankis, Vaghela, and Gujarat Sultanate.',
            icon: Icons.fort_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegionalGujaratPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Medieval Gujarat',
            subtitle: 'Golden Age of Solankis and Ahmedabad foundation.',
            icon: Icons.castle_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MedievalGujaratPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'British Rule in Gujarat',
            subtitle: 'Colonial administration and economic shifts.',
            icon: Icons.business_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BritishRuleGujaratPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Freedom Movement in Gujarat',
            subtitle: 'Gandhian experiments and regional resistance.',
            icon: Icons.auto_awesome_motion_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FreedomMovementGujaratPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Important Personalities of Gujarat',
            subtitle: 'Life and contributions of Gandhi, Patel, and more.',
            icon: Icons.face_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImportantPersonalitiesGujaratPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Culture & Heritage of Gujarat',
            subtitle: 'UNESCO sites, festivals, and folk traditions.',
            icon: Icons.auto_fix_high_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CultureHeritageGujaratPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'Modern History',
            subtitle: 'Colonial era, freedom struggle, and independence.',
          ),
          SectionItemCard(
            title: 'Advent of Europeans',
            subtitle: 'Portuguese, Dutch, British, and French in India.',
            icon: Icons.sailing_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdventOfEuropeansPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'British Expansion',
            subtitle: 'Rise of EIC and administrative consolidation.',
            icon: Icons.map_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BritishExpansionPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Revolt of 1857',
            subtitle: "The first major uprising against British rule.",
            icon: Icons.military_tech,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Revolt1857Page(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Revolutionary Movements',
            subtitle: 'Heroic actions and the Indian National Army.',
            icon: Icons.military_tech_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RevolutionaryMovementsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Socio-Religious Reforms',
            subtitle: 'Indian Renaissance and modern awakenings.',
            icon: Icons.auto_stories_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SocioReligiousReformPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Constitutional Development',
            subtitle: 'Acts and legal evolution in British India.',
            icon: Icons.gavel_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConstitutionalDevelopmentPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Gandhian Era',
            subtitle: 'National movement under Mahatma Gandhi.',
            icon: Icons.person_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GandhianEraPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'INC (Early Phase)',
            subtitle: 'Moderates, Extremists, and the birth of INC.',
            icon: Icons.groups_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const INCEarlyPhasePage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Freedom Struggle (Final Phase)',
            subtitle: 'Road to independence and partition.',
            icon: Icons.flag_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FreedomStruggleFinalPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'More Topics Coming Soon...',
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
