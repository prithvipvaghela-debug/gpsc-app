import 'package:flutter/material.dart';
import '../services/analytics_service.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/app_card.dart';
import '../widgets/section_title.dart';
import 'analytics_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GpscPageScaffold(
      title: 'Profile',
      child: FutureBuilder<Map<String, dynamic>>(
        future: AnalyticsService().getStats(),
        builder: (context, snapshot) {
          final stats = snapshot.data ?? {'tests': 0, 'correct': 0, 'wrong': 0};
          final int totalTests = stats['tests']!;
          final int correct = stats['correct']!;
          final int wrong = stats['wrong']!;
          final int totalAnswers = correct + wrong;
          
          final double accuracy = totalAnswers > 0 ? (correct / totalAnswers) : 0.0;
          final String accuracyText = '${(accuracy * 100).toStringAsFixed(0)}%';

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildStatCard(context, Icons.assignment_turned_in_rounded, totalTests.toString(), 'Tests Done'),
                      const SizedBox(width: 12),
                      _buildStatCard(context, Icons.analytics_rounded, accuracyText, 'Accuracy'),
                      const SizedBox(width: 12),
                      _buildStatCard(context, Icons.local_fire_department_rounded, '1', 'Day Streak'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                _buildOptionsSection(context),
                const SizedBox(height: 40),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
            ),
            child: CircleAvatar(
              radius: 40,
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
          const SizedBox(height: 16),
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

  Widget _buildStatCard(BuildContext context, IconData icon, String value, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Expanded(
      child: AppCard(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Icon(icon, color: colorScheme.primary, size: 22),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'Account Settings'),
          _ProfileOptionTile(icon: Icons.edit_outlined, title: 'Edit Profile'),
          SizedBox(height: 12),
          _ProfileOptionTile(icon: Icons.insights_rounded, title: 'Exam Analytics', destination: AnalyticsScreen()),
          SizedBox(height: 12),
          _ProfileOptionTile(icon: Icons.logout_rounded, title: 'Logout', isDestructive: true),
        ],
      ),
    );
  }
}

class _ProfileOptionTile extends StatelessWidget {
  const _ProfileOptionTile({
    required this.icon,
    required this.title,
    this.destination,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final Widget? destination;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = isDestructive ? colorScheme.error : colorScheme.primary;

    return AppCard(
      onTap: () {
        if (destination != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => destination!));
        }
      },
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDestructive ? colorScheme.error : colorScheme.onSurface,
              ),
            ),
          ),
          Icon(Icons.chevron_right_rounded, 
              size: 20, color: colorScheme.onSurfaceVariant.withOpacity(0.3)),
        ],
      ),
    );
  }
}
