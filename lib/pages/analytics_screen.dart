import 'package:flutter/material.dart';
import '../services/analytics_service.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/app_card.dart';
import '../widgets/section_title.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GpscPageScaffold(
      title: 'Performance Analytics',
      child: FutureBuilder<Map<String, dynamic>>(
        future: AnalyticsService().getDashboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final history = data['history'] as List<Map<String, dynamic>>;
          final topics = data['topics'] as Map<String, dynamic>;
          final double globalAccuracy = data['globalAccuracy'];

          if (data['totalAttempts'] == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined, size: 64, color: colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('No Data Available', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const Text('Complete a test to see your performance analytics.'),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 1. OVERALL MASTERY CARD
              AppCard(
                color: colorScheme.primary,
                child: Column(
                  children: [
                    Text('Global Accuracy', style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary)),
                    const SizedBox(height: 8),
                    Text('${globalAccuracy.toStringAsFixed(1)}%', 
                      style: theme.textTheme.displaySmall?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMiniStat(data['totalTests'].toString(), 'Tests', colorScheme.onPrimary),
                        _buildMiniStat(data['totalCorrect'].toString(), 'Correct', colorScheme.onPrimary),
                        _buildMiniStat(data['totalWrong'].toString(), 'Wrong', colorScheme.onPrimary),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 2. AI RECOMMENDATIONS
              const SectionTitle(title: 'Study Recommendations', subtitle: 'Intelligent focus areas'),
              FutureBuilder<List<String>>(
                future: AnalyticsService().getRecommendations(),
                builder: (context, recSnapshot) {
                  final recs = recSnapshot.data ?? [];
                  return Column(
                    children: recs.map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: AppCard(
                        borderSide: BorderSide(color: colorScheme.primary.withOpacity(0.2)),
                        child: Row(
                          children: [
                            Icon(Icons.auto_awesome, color: colorScheme.primary, size: 20),
                            const SizedBox(width: 12),
                            Expanded(child: Text(r, style: theme.textTheme.bodyMedium)),
                          ],
                        ),
                      ),
                    )).toList(),
                  );
                },
              ),

              const SizedBox(height: 32),

              // 3. WEAK TOPICS (DANGER ZONE)
              const SectionTitle(title: 'Critical Weak Areas', subtitle: 'Accuracy below 60%'),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: AnalyticsService().getWeakTopics(),
                builder: (context, weakSnapshot) {
                  final weak = weakSnapshot.data ?? [];
                  if (weak.isEmpty) {
                    return const AppCard(child: Center(child: Text('No critical weak areas detected!')));
                  }
                  return Column(
                    children: weak.map((w) => _buildTopicTile(theme, w, true)).toList(),
                  );
                },
              ),

              const SizedBox(height: 32),

              // 4. TOPIC-WISE PERFORMANCE
              const SectionTitle(title: 'Subject Mastery', subtitle: 'Performance across categories'),
              ...topics.entries.map((e) {
                final stats = Map<String, dynamic>.from(e.value);
                final total = stats['total'] ?? 0;
                final correct = stats['correct'] ?? 0;
                final acc = total > 0 ? (correct / total) * 100 : 0.0;
                return _buildTopicTile(theme, {
                  'topic': e.key.replaceAll('_', ' ').toUpperCase(),
                  'accuracy': acc,
                  'total': total,
                }, false);
              }),

              const SizedBox(height: 32),

              // 5. RECENT TRENDS
              const SectionTitle(title: 'Performance Trend', subtitle: 'Last 10 attempts'),
              ...history.map((h) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: double.parse(h['accuracy']) >= 70 ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  child: Icon(
                    double.parse(h['accuracy']) >= 70 ? Icons.trending_up : Icons.trending_down,
                    color: double.parse(h['accuracy']) >= 70 ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(h['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(h['date'].toString().split('T')[0]),
                trailing: Text('${h['accuracy']}%', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              )),
              
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(color: color.withOpacity(0.8), fontSize: 12)),
      ],
    );
  }

  Widget _buildTopicTile(ThemeData theme, Map<String, dynamic> data, bool isCritical) {
    final double acc = data['accuracy'];
    final color = isCritical ? Colors.red : (acc >= 70 ? Colors.green : Colors.orange);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data['topic'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${acc.toStringAsFixed(0)}%', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: acc / 100,
              backgroundColor: color.withOpacity(0.1),
              color: color,
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 4),
            Text('Attempts: ${data['total']}', style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
