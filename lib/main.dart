import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'pages/analytics_screen.dart';
import 'pages/bookmarks_page.dart';
import 'pages/chat_screen.dart';
import 'pages/current_affairs_page.dart';
import 'pages/history_screen.dart';
import 'pages/mock_test_page.dart';
import 'pages/previous_year_questions_page.dart';
import 'pages/profile_screen.dart';
import 'pages/search_page.dart';
import 'pages/study_material_page.dart';
import 'services/persistence_service.dart';
import 'services/analytics_service.dart';
import 'theme.dart';
import 'widgets/app_card.dart';
import 'widgets/gpsc_page_scaffold.dart';
import 'widgets/section_cards.dart';
import 'widgets/section_title.dart';
import 'widgets/theme_toggle_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }
  await PersistenceService().init();
  runApp(const GpscApp());
}

class GpscApp extends StatelessWidget {
  const GpscApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appThemeMode,
      builder: (_, ThemeMode currentMode, _) {
        return MaterialApp(
          title: 'GPSC Exam Prep',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          home: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: const HomeScreen(),
            ),
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _openDrawerPage(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawerScrimColor: Colors.black.withOpacity(0.25),
      appBar: AppBar(
        title: const Text('GPSC Prep'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ThemeToggleButton(),
          ),
        ],
      ),
      drawer: _buildPremiumDrawer(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildTopActions(context),
          const SizedBox(height: 24),
          const SectionHeaderCard(
            title: 'Success Starts Here',
            subtitle: 'Begin your GPSC preparation journey today.',
            icon: Icons.auto_awesome_rounded,
          ),
          const SizedBox(height: 32),
          _buildContinueLearning(context),
          _buildRecommendations(context),
          const SectionTitle(title: 'Explore Topics'),
          SectionItemCard(
            title: 'Study Material',
            subtitle: 'Detailed notes and chapters for all subjects',
            icon: Icons.menu_book_rounded,
            isPrimary: true,
            onTap: () => _openPage(context, const StudyMaterialScreen()),
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Mock Test',
            subtitle: 'Challenge yourself with full-length tests',
            icon: Icons.assignment_turned_in_rounded,
            isPrimary: true,
            onTap: () => _openPage(context, const MockTestPage()),
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Current Affairs',
            subtitle: 'Stay updated with regional and national news',
            icon: Icons.newspaper_rounded,
            isPrimary: true,
            onTap: () => _openPage(context, const CurrentAffairsPage()),
          ),
          const SizedBox(height: 12),
          SectionItemCard(
            title: 'Previous Papers',
            subtitle: 'Analyze and solve past GPSC questions',
            icon: Icons.history_edu_rounded,
            isPrimary: true,
            onTap: () => _openPage(
              context,
              const PreviousYearQuestionsPage(),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTopActions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _TopActionButton(
                label: 'Search',
                icon: Icons.search_rounded,
                onTap: () => _openPage(context, const SearchPage()),
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TopActionButton(
                label: 'Favorites',
                icon: Icons.bookmark_rounded,
                onTap: () => _openPage(context, const BookmarksPage()),
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _TopActionButton(
                label: 'Ask AI',
                icon: Icons.auto_fix_high_rounded,
                onTap: () => _openPage(context, const ChatScreen()),
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TopActionButton(
                label: 'Analytics',
                icon: Icons.analytics_rounded,
                onTap: () => _openPage(context, const AnalyticsScreen()),
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPremiumDrawer(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      width: 280,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildPremiumHeader(context),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                children: [
                  _buildDrawerTile(
                    context,
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                    onTap: () => _openDrawerPage(context, const ProfileScreen()),
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () => _openDrawerPage(context, const SettingsScreen()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Divider(height: 1, color: theme.dividerTheme.color?.withOpacity(0.5)),
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.call_outlined,
                    label: 'Contact Us',
                    onTap: () => _openDrawerPage(context, const ContactScreen()),
                  ),
                  _buildDrawerTile(
                    context,
                    icon: Icons.info_outline_rounded,
                    label: 'About',
                    onTap: () => _openDrawerPage(context, const AboutScreen()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'GPSC PREP v1.0.0',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.4),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
            ),
            child: CircleAvatar(
              radius: 36,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Text(
                'P',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Prithvi',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'GPSC Aspirant',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      leading: Icon(icon, color: colorScheme.primary, size: 22),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _buildContinueLearning(BuildContext context) {
    final ps = PersistenceService();
    return ValueListenableBuilder<String?>(
      valueListenable: ps.lastOpenedChapterId,
      builder: (context, chapterId, _) {
        if (chapterId == null) return const SizedBox.shrink();

        final subject = ps.lastOpenedSubject.value ?? '';
        final theme = Theme.of(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Continue Learning'),
            AppCard(
              onTap: () => _openChapter(context, chapterId, subject),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.play_circle_filled_rounded,
                        color: theme.colorScheme.primary, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapterId.replaceAll('_', ' ').toUpperCase(),
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Subject: $subject',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded,
                      size: 20, color: theme.colorScheme.onSurfaceVariant.withOpacity(0.3)),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }

  void _openChapter(BuildContext context, String chapterId, String subject) {
    if (subject == 'History') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HistoryScreen()),
      );
    }
  }

  Widget _buildRecommendations(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FutureBuilder<List<String>>(
      future: AnalyticsService().getStudyRecommendations(),
      builder: (context, snapshot) {
        final List<String> recommendations = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(title: 'Recommended for You'),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: recommendations.isEmpty
                    ? [
                        Row(
                          children: [
                            const Icon(Icons.stars_rounded, color: Colors.amber, size: 24),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Excellent job! No weak areas 🎉',
                                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ]
                    : recommendations.map((rec) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Icon(Icons.lightbulb_rounded, color: colorScheme.primary, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  rec,
                                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
              ),
            ),
            const SizedBox(height: 32),
          ],
        );
      },
    );
  }
}

class _TopActionButton extends StatefulWidget {
  const _TopActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  State<_TopActionButton> createState() => _TopActionButtonState();
}

class _TopActionButtonState extends State<_TopActionButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: AppCard(
          color: isDark ? widget.color.withOpacity(0.15) : widget.color.withOpacity(0.1),
          padding: EdgeInsets.zero,
          onTap: widget.onTap,
          borderRadius: 16,
          borderSide: BorderSide(color: widget.color.withOpacity(0.2)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Icon(widget.icon, color: widget.color, size: 24),
                const SizedBox(height: 8),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: isDark ? Colors.white : widget.color.darken(0.2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension ColorExtension on Color {
  Color darken(double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

// Placeholder Screens
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Settings',
      child: const Center(child: Text('Settings Screen')),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'Contact Us',
      child: const Center(child: Text('Contact Screen')),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: 'About',
      child: const Center(child: Text('About Screen')),
    );
  }
}
