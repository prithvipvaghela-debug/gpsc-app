import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizStats {
  final double lastScore;
  final double bestScore;
  final int totalAttempts;

  QuizStats({
    required this.lastScore,
    required this.bestScore,
    required this.totalAttempts,
  });

  Map<String, dynamic> toMap() {
    return {
      'lastScore': lastScore,
      'bestScore': bestScore,
      'totalAttempts': totalAttempts,
    };
  }

  factory QuizStats.fromMap(Map<String, dynamic> map) {
    return QuizStats(
      lastScore: (map['lastScore'] ?? 0.0).toDouble(),
      bestScore: (map['bestScore'] ?? 0.0).toDouble(),
      totalAttempts: (map['totalAttempts'] ?? 0).toInt(),
    );
  }

  String encode() => '$lastScore:$bestScore:$totalAttempts';

  factory QuizStats.decode(String encoded) {
    final parts = encoded.split(':');
    if (parts.length == 3) {
      return QuizStats(
        lastScore: double.tryParse(parts[0]) ?? 0.0,
        bestScore: double.tryParse(parts[1]) ?? 0.0,
        totalAttempts: int.tryParse(parts[2]) ?? 0,
      );
    }
    return QuizStats(lastScore: 0, bestScore: 0, totalAttempts: 0);
  }
}

class PersistenceService {
  static final PersistenceService _instance = PersistenceService._internal();
  factory PersistenceService() => _instance;
  PersistenceService._internal();

  late SharedPreferences _prefs;
  
  // ValueNotifiers for reactive UI
  final ValueNotifier<Set<String>> completedChapters = ValueNotifier<Set<String>>({});
  final ValueNotifier<Set<String>> bookmarkedChapters = ValueNotifier<Set<String>>({});
  final ValueNotifier<Map<String, QuizStats>> quizStats = ValueNotifier<Map<String, QuizStats>>({});
  final ValueNotifier<String?> lastOpenedChapterId = ValueNotifier<String?>(null);
  final ValueNotifier<String?> lastOpenedSubject = ValueNotifier<String?>(null);

  static const String _keyCompletedChapters = 'completed_chapters';
  static const String _keyBookmarkedChapters = 'bookmarked_chapters';
  static const String _keyQuizStats = 'quiz_performance_stats';
  static const String _keyLastOpenedChapterId = 'last_opened_chapter_id';
  static const String _keyLastOpenedSubject = 'last_opened_subject';
  
  // Rule 1: Add high score key and methods
  static const String _highScoreKey = "quiz_high_score";

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load completed chapters
    final List<String>? chapters = _prefs.getStringList(_keyCompletedChapters);
    if (chapters != null) {
      completedChapters.value = chapters.toSet();
    }

    // Load bookmarked chapters
    final List<String>? bookmarks = _prefs.getStringList(_keyBookmarkedChapters);
    if (bookmarks != null) {
      bookmarkedChapters.value = bookmarks.toSet();
    }

    // Load last opened info
    lastOpenedChapterId.value = _prefs.getString(_keyLastOpenedChapterId);
    lastOpenedSubject.value = _prefs.getString(_keyLastOpenedSubject);

    // Load quiz stats
    final List<String>? statsList = _prefs.getStringList(_keyQuizStats);
    if (statsList != null) {
      final Map<String, QuizStats> statsMap = {};
      for (var entry in statsList) {
        final colonIndex = entry.indexOf(':');
        if (colonIndex != -1) {
          final id = entry.substring(0, colonIndex);
          final data = entry.substring(colonIndex + 1);
          statsMap[id] = QuizStats.decode(data);
        }
      }
      quizStats.value = statsMap;
    }
  }

  // Rule 1: Add getHighScore and setHighScore
  Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }

  Future<void> setHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    int current = prefs.getInt(_highScoreKey) ?? 0;
    if (score > current) {
      await prefs.setInt(_highScoreKey, score);
    }
  }

  // --- Chapter Progress ---

  bool isChapterCompleted(String id) {
    return completedChapters.value.contains(id);
  }

  Future<void> markChapterCompleted(String id) async {
    final newSet = Set<String>.from(completedChapters.value);
    newSet.add(id);
    completedChapters.value = newSet;
    await _prefs.setStringList(_keyCompletedChapters, newSet.toList());
  }

  Future<void> unmarkChapterCompleted(String id) async {
    final newSet = Set<String>.from(completedChapters.value);
    newSet.remove(id);
    completedChapters.value = newSet;
    await _prefs.setStringList(_keyCompletedChapters, newSet.toList());
  }

  // --- Bookmarks ---

  bool isBookmarked(String id) {
    return bookmarkedChapters.value.contains(id);
  }

  Future<void> toggleBookmark(String id) async {
    final newSet = Set<String>.from(bookmarkedChapters.value);
    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }
    bookmarkedChapters.value = newSet;
    await _prefs.setStringList(_keyBookmarkedChapters, newSet.toList());
  }

  // --- Continue Learning ---

  Future<void> setLastOpenedChapter(String id, String subject) async {
    lastOpenedChapterId.value = id;
    lastOpenedSubject.value = subject;
    await _prefs.setString(_keyLastOpenedChapterId, id);
    await _prefs.setString(_keyLastOpenedSubject, subject);
  }

  // --- Quiz Progress ---

  QuizStats getQuizStats(String quizId) {
    return quizStats.value[quizId] ?? QuizStats(lastScore: 0, bestScore: 0, totalAttempts: 0);
  }

  Future<void> saveQuizScore(String quizId, double score) async {
    final currentStats = getQuizStats(quizId);
    
    final newBestScore = score > currentStats.bestScore ? score : currentStats.bestScore;
    final newTotalAttempts = currentStats.totalAttempts + 1;
    
    final newStats = QuizStats(
      lastScore: score,
      bestScore: newBestScore,
      totalAttempts: newTotalAttempts,
    );

    final newMap = Map<String, QuizStats>.from(quizStats.value);
    newMap[quizId] = newStats;
    quizStats.value = newMap;
    
    final List<String> encodedScores = newMap.entries
        .map((e) => '${e.key}:${e.value.encode()}')
        .toList();
    await _prefs.setStringList(_keyQuizStats, encodedScores);
    
    // Also update global high score for simple integer tracking if needed
    await setHighScore(score.toInt());
  }
}
