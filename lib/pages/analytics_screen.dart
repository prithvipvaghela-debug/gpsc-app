import 'package:flutter/material.dart';
import '../services/analytics_service.dart';
import '../widgets/app_card.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_title.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GpscPageScaffold(
      title: 'Exam Analytics',
      child: FutureBuilder<Map<String, dynamic>>(
        future: AnalyticsService().getStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final Map<String, dynamic> stats = Map<String, dynamic>.from(snapshot.data ?? {
            'tests': 0,
            'correct': 0,
            'wrong': 0,
            'subjects': <String, dynamic>{}
          });

          final int totalTests = stats['tests'] as int;
          if (totalTests == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined, size: 80, color: colorScheme.primary.withOpacity(0.2)),
                  const SizedBox(height: 16),
                  Text(
                    'No Data Available',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Start attempting tests to see analytics'),
                ],
              ),
            );
          }

          final int correct = stats['correct'] as int;
          final int wrong = stats['wrong'] as int;
          
          double accuracy = 0;
          if ((correct + wrong) > 0) {
            accuracy = correct / (correct + wrong);
          }
          
          final String accuracyText = '${(accuracy * 100).toStringAsFixed(1)}%';

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP STATS GRID
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Total Tests',
                        value: totalTests.toString(),
                        icon: Icons.assignment_turned_in_rounded,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Accuracy',
                        value: accuracyText,
                        icon: Icons.track_changes_rounded,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Correct',
                        value: correct.toString(),
                        icon: Icons.check_circle_rounded,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Wrong',
                        value: wrong.toString(),
                        icon: Icons.cancel_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                
                // 2. OVERALL PROGRESS
                const SectionTitle(title: 'Overall Performance'),
                AppCard(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Accuracy Level'),
                          Text(accuracyText, style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: accuracy,
                          minHeight: 10,
                          backgroundColor: colorScheme.primary.withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // 3. WEAK AREAS SECTION
                const SectionTitle(title: 'Weak Areas', subtitle: '<70% accuracy'),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: AnalyticsService().getWeakTopics(),
                  builder: (context, weakSnapshot) {
                    if (!weakSnapshot.hasData || weakSnapshot.data!.isEmpty) {
                      return const AppCard(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Text('No weak areas detected! Keep it up.', 
                              style: TextStyle(fontStyle: FontStyle.italic)),
                          ),
                        ),
                      );
                    }

                    final weakTopics = weakSnapshot.data!;
                    return Column(
                      children: weakTopics.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: AppCard(
                            borderSide: BorderSide(color: Colors.red.withOpacity(0.1)),
                            child: Row(
                              children: [
                                Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item['topic'].toString().replaceAll('_', ' '), 
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  '${(item['accuracy'] as double).toStringAsFixed(0)}% accuracy',
                                  style: TextStyle(color: Colors.red.shade400, fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
