import 'package:flutter/material.dart';

import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import '../widgets/section_title.dart';
import 'coming_soon_page.dart';

class CurrentAffairsPage extends StatelessWidget {
  const CurrentAffairsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Current Affairs',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          const SectionHeaderCard(
            title: 'Stay updated every day',
            subtitle:
                'Current affairs are important for GPSC, so revise key events regularly.',
            icon: Icons.newspaper_rounded,
          ),
          const SizedBox(height: 32),
          const SectionTitle(
            title: 'News Categories',
            subtitle: 'Follow daily updates across different domains.',
          ),
          SectionItemCard(
            title: 'National News',
            subtitle:
                'Follow important government schemes, policies, and national events.',
            icon: Icons.flag_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComingSoonPage(
                    title: 'National News',
                    icon: Icons.flag_rounded,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'State News',
            subtitle:
                'Track Gujarat-related updates, development projects, and local issues.',
            icon: Icons.location_city_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComingSoonPage(
                    title: 'State News',
                    icon: Icons.location_city_rounded,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Important Dates and Events',
            subtitle:
                'Revise awards, appointments, summits, reports, and special days.',
            icon: Icons.event_note_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComingSoonPage(
                    title: 'Important Dates',
                    icon: Icons.event_note_rounded,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
