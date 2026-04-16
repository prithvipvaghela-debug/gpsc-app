import 'dart:convert';
import 'dart:developer' as developer;
import 'package:shared_preferences/shared_preferences.dart';

/// Senior Data Engineer Exam Analytics Service
/// Advanced tracking of user performance, trends, and weak areas.
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  // Keys
  static const String _keyTotalTests = 'total_tests_v2';
  static const String _keyGlobalCorrect = 'global_correct_v2';
  static const String _keyGlobalWrong = 'global_wrong_v2';
  static const String _keyTopicStats = 'topic_performance_stats_v2';
  static const String _keyHistory = 'test_history_v2'; // Stores list of recent scores
  static const String _keyTotalTimeSeconds = 'total_time_spent_v2';

  /// Enhanced: Records a full test result with history tracking
  Future<void> saveTestResult(String title, int correct, int wrong, {int? durationSeconds}) async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Update Global Counters
    final int totalTests = (prefs.getInt(_keyTotalTests) ?? 0) + 1;
    final int totalCorrect = (prefs.getInt(_keyGlobalCorrect) ?? 0) + correct;
    final int totalWrong = (prefs.getInt(_keyGlobalWrong) ?? 0) + wrong;
    
    await prefs.setInt(_keyTotalTests, totalTests);
    await prefs.setInt(_keyGlobalCorrect, totalCorrect);
    await prefs.setInt(_keyGlobalWrong, totalWrong);

    if (durationSeconds != null) {
      final int totalTime = (prefs.getInt(_keyTotalTimeSeconds) ?? 0) + durationSeconds;
      await prefs.setInt(_keyTotalTimeSeconds, totalTime);
    }

    // 2. Performance Trend (Last 10 Tests)
    final double accuracy = (correct + wrong > 0) ? (correct / (correct + wrong)) * 100 : 0;
    List<String> history = prefs.getStringList(_keyHistory) ?? [];
    
    Map<String, dynamic> entry = {
      'title': title,
      'correct': correct,
      'wrong': wrong,
      'accuracy': accuracy.toStringAsFixed(1),
      'date': DateTime.now().toIso8601String(),
    };
    
    history.insert(0, json.encode(entry));
    if (history.length > 10) history = history.sublist(0, 10);
    
    await prefs.setStringList(_keyHistory, history);
    developer.log('Analytics: Saved test result for $title', name: 'Analytics');
  }

  /// Enhanced: Granular topic tracking
  Future<void> recordQuestionResult({
    required String topic,
    required bool isCorrect,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String topicKey = topic.toLowerCase().trim().replaceAll(' ', '_');
    
    final String? dataString = prefs.getString(_keyTopicStats);
    Map<String, dynamic> data = dataString != null ? json.decode(dataString) : {};

    if (!data.containsKey(topicKey)) {
      data[topicKey] = {'correct': 0, 'wrong': 0, 'total': 0};
    }

    Map<String, dynamic> stats = Map<String, dynamic>.from(data[topicKey]);
    stats['total'] = (stats['total'] as int) + 1;
    if (isCorrect) {
      stats['correct'] = (stats['correct'] as int) + 1;
    } else {
      stats['wrong'] = (stats['wrong'] as int) + 1;
    }
    
    data[topicKey] = stats;
    await prefs.setString(_keyTopicStats, json.encode(data));
  }

  /// Weak Topic Detection (Accuracy < 60%)
  Future<List<Map<String, dynamic>>> getWeakTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString(_keyTopicStats);
    if (dataString == null) return [];

    Map<String, dynamic> data = json.decode(dataString);
    List<Map<String, dynamic>> results = [];

    data.forEach((topicKey, stats) {
      final int correct = stats['correct'] ?? 0;
      final int total = stats['total'] ?? 0;
      
      if (total >= 5) { // Only suggest after enough attempts
        final double accuracy = (correct / total) * 100;
        if (accuracy < 60) {
          results.add({
            'topic': topicKey.replaceAll('_', ' ').toUpperCase(),
            'accuracy': accuracy,
            'total': total,
            'correct': correct,
            'wrong': stats['wrong'] ?? 0,
          });
        }
      }
    });

    results.sort((a, b) => (a['accuracy'] as double).compareTo(b['accuracy'] as double));
    return results;
  }

  /// Smart Recommendation Engine
  Future<List<String>> getRecommendations() async {
    final weakTopics = await getWeakTopics();
    if (weakTopics.isEmpty) return ["Excellent work! Keep maintaining your current practice pace."];

    final List<String> recs = [];
    for (int i = 0; i < weakTopics.length && i < 3; i++) {
      final topic = weakTopics[i]['topic'];
      final accuracy = (weakTopics[i]['accuracy'] as double).toStringAsFixed(0);
      
      if (i == 0) {
        recs.add("URGENT: Your accuracy in $topic is only $accuracy%. Focus 70% of your study time here.");
      } else {
        recs.add("Consider re-practicing foundational concepts of $topic.");
      }
    }
    return recs;
  }

  /// Comprehensive Dashboard Data
  Future<Map<String, dynamic>> getDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    
    final int totalTests = prefs.getInt(_keyTotalTests) ?? 0;
    final int totalCorrect = prefs.getInt(_keyGlobalCorrect) ?? 0;
    final int totalWrong = prefs.getInt(_keyGlobalWrong) ?? 0;
    final int totalAttempts = totalCorrect + totalWrong;
    final double globalAccuracy = totalAttempts > 0 ? (totalCorrect / totalAttempts) * 100 : 0;
    
    // Topic Wise Accuracy
    final String? dataString = prefs.getString(_keyTopicStats);
    Map<String, dynamic> topicData = dataString != null ? json.decode(dataString) : {};
    
    // History
    final List<String> historyStrings = prefs.getStringList(_keyHistory) ?? [];
    final List<Map<String, dynamic>> history = historyStrings
        .map((s) => Map<String, dynamic>.from(json.decode(s)))
        .toList();

    return {
      'totalTests': totalTests,
      'totalCorrect': totalCorrect,
      'totalWrong': totalWrong,
      'totalAttempts': totalAttempts,
      'globalAccuracy': globalAccuracy,
      'history': history,
      'topics': topicData,
      'avgTimePerQuestion': totalAttempts > 0 ? (prefs.getInt(_keyTotalTimeSeconds) ?? 0) / totalAttempts : 0,
    };
  }

  /// Legacy Compatibility: Study Recommendations
  Future<List<String>> getStudyRecommendations() async {
    return getRecommendations();
  }

  /// Legacy Compatibility: Stats
  Future<Map<String, dynamic>> getStats() async {
    final data = await getDashboardData();
    return {
      'tests': data['totalTests'],
      'correct': data['totalCorrect'],
      'wrong': data['totalWrong'],
      'subjects': data['topics'], // Map of topic stats
    };
  }
}
