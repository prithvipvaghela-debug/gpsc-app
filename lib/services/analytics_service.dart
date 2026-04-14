import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsService {
  static const String _keyTotalTests = 'total_tests';
  static const String _keyTotalCorrect = 'total_correct';
  static const String _keyTotalWrong = 'total_wrong';
  static const String _keyTopicStats = 'topic_performance_stats';

  static const List<String> subjects = ['Economy', 'Science & Tech', 'Environment', 'History', 'General'];

  Future<void> saveTestResult(String subject, int correct, int wrong) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Global stats
    int totalTests = prefs.getInt(_keyTotalTests) ?? 0;
    int totalCorrect = prefs.getInt(_keyTotalCorrect) ?? 0;
    int totalWrong = prefs.getInt(_keyTotalWrong) ?? 0;

    await prefs.setInt(_keyTotalTests, totalTests + 1);
    await prefs.setInt(_keyTotalCorrect, totalCorrect + correct);
    await prefs.setInt(_keyTotalWrong, totalWrong + wrong);

    // Subject-wise stats
    final String subjectKey = subject.toLowerCase().replaceAll(' ', '_');
    int subjectCorrect = prefs.getInt('${subjectKey}_correct') ?? 0;
    int subjectWrong = prefs.getInt('${subjectKey}_wrong') ?? 0;

    await prefs.setInt('${subjectKey}_correct', subjectCorrect + correct);
    await prefs.setInt('${subjectKey}_wrong', subjectWrong + wrong);
  }

  Future<void> recordQuestionResult({
    required String topic,
    required bool isCorrect,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString(_keyTopicStats);
    Map<String, dynamic> data = {};

    if (dataString != null) {
      data = Map<String, dynamic>.from(json.decode(dataString));
    }

    if (!data.containsKey(topic)) {
      data[topic] = {'correct': 0, 'wrong': 0};
    }

    Map<String, dynamic> stats = Map<String, dynamic>.from(data[topic]);
    if (isCorrect) {
      stats['correct'] = (stats['correct'] as int) + 1;
    } else {
      stats['wrong'] = (stats['wrong'] as int) + 1;
    }
    
    data[topic] = stats;
    await prefs.setString(_keyTopicStats, json.encode(data));
  }

  Future<List<Map<String, dynamic>>> getWeakTopics() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dataString = prefs.getString(_keyTopicStats);
    if (dataString == null) return [];

    Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(dataString));
    List<Map<String, dynamic>> weakTopicsList = [];

    data.forEach((topic, stats) {
      final Map<String, dynamic> topicStats = Map<String, dynamic>.from(stats);
      final int correct = topicStats['correct'] as int;
      final int wrong = topicStats['wrong'] as int;
      final int total = correct + wrong;

      if (total > 0) {
        final double accuracy = (correct / total) * 100;
        if (accuracy < 70) {
          weakTopicsList.add({
            'topic': topic,
            'accuracy': accuracy,
            'wrongCount': wrong,
          });
        }
      }
    });

    // Sort by highest wrong count or lowest accuracy
    weakTopicsList.sort((a, b) => (a['accuracy'] as double).compareTo(b['accuracy'] as double));

    return weakTopicsList;
  }

  Future<List<String>> getStudyRecommendations() async {
    final weakTopics = await getWeakTopics();
    final List<String> recommendations = [];

    for (int i = 0; i < weakTopics.length && i < 3; i++) {
      final String topic = weakTopics[i]['topic'].toString().replaceAll('_', ' ');
      if (i == 0) {
        recommendations.add("Revise $topic thoroughly to improve concepts.");
      } else if (i == 1) {
        recommendations.add("Practice more MCQs for $topic to gain confidence.");
      } else {
        recommendations.add("Focus on improving accuracy in $topic.");
      }
    }

    return recommendations;
  }

  Future<Map<String, dynamic>> getStats() async {
    final prefs = await SharedPreferences.getInstance();
    
    Map<String, dynamic> subjectsStats = {};

    for (String subject in subjects) {
      final String subjectKey = subject.toLowerCase().replaceAll(' ', '_');
      subjectsStats[subject] = {
        'correct': prefs.getInt('${subjectKey}_correct') ?? 0,
        'wrong': prefs.getInt('${subjectKey}_wrong') ?? 0,
      };
    }

    return {
      'tests': prefs.getInt(_keyTotalTests) ?? 0,
      'correct': prefs.getInt(_keyTotalCorrect) ?? 0,
      'wrong': prefs.getInt(_keyTotalWrong) ?? 0,
      'subjects': subjectsStats,
    };
  }
}
