import 'dart:async';
import 'dart:developer' as developer;
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_progress.dart';

/// Senior Architect Auto-Save Service
/// Uses Hive for high-performance, asynchronous disk writes.
class AutoSaveService {
  static final AutoSaveService _instance = AutoSaveService._internal();
  factory AutoSaveService() => _instance;
  AutoSaveService._internal();

  static const String _boxName = 'user_progress_box';
  Box<UserProgress>? _progressBox;
  
  final Map<String, Timer> _debounceTimers = {};
  static const Duration _debounceDuration = Duration(milliseconds: 500);

  /// Initializes Hive and opens the progress box
  Future<void> init() async {
    try {
      // Ensure Hive is initialized for Flutter
      await Hive.initFlutter();
      
      // Register generated adapter
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(UserProgressAdapter());
      }
      
      // Open the box safely
      _progressBox = await Hive.openBox<UserProgress>(_boxName);
      developer.log('AutoSaveService: Hive initialized and box opened.', name: 'AutoSave');
    } catch (e) {
      developer.log('AutoSaveService Initialization Error: $e', name: 'AutoSave', level: 1000);
      // We don't rethrow here to prevent app crash, but the service will be inactive
    }
  }

  /// Safe access to the box
  Box<UserProgress>? get _box {
    if (_progressBox == null || !_progressBox!.isOpen) {
      developer.log('Warning: AutoSave box accessed but not open.', name: 'AutoSave');
      return null;
    }
    return _progressBox;
  }

  void saveProgress(UserProgress progress) {
    final String key = progress.questionId;
    _debounceTimers[key]?.cancel();
    
    _debounceTimers[key] = Timer(_debounceDuration, () async {
      try {
        await _box?.put(key, progress);
        _debounceTimers.remove(key);
      } catch (e) {
        developer.log('Save Error for $key: $e', name: 'AutoSave', level: 1000);
      }
    });
  }

  Future<void> saveProgressNow(UserProgress progress) async {
    final String key = progress.questionId;
    _debounceTimers[key]?.cancel();
    _debounceTimers.remove(key);
    try {
      await _box?.put(key, progress);
    } catch (e) {
      developer.log('Immediate Save Error for $key: $e', name: 'AutoSave', level: 1000);
    }
  }

  UserProgress? getProgress(String questionId) {
    return _box?.get(questionId);
  }

  List<UserProgress> getAllProgress() {
    return _box?.values.toList() ?? [];
  }

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> dispose() async {
    for (var timer in _debounceTimers.values) {
      timer.cancel();
    }
    await _progressBox?.close();
  }
}
