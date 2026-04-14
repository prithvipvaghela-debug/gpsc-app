import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';

/// Senior Engineer Data Recovery Service
/// Handles safe loading of JSON assets with automatic backup restoration.
class DataRecoveryService {
  static const String _tag = 'DataRecovery';

  /// Loads a JSON asset with a fallback to a backup if the primary is missing or corrupted.
  static Future<T?> loadSafeJson<T>(String primaryPath) async {
    final String backupPath = primaryPath.replaceFirst('.json', '_backup.json');

    // 1. Try loading primary
    try {
      final String content = await rootBundle.loadString(primaryPath);
      final T data = json.decode(content);
      developer.log('Successfully loaded primary data: $primaryPath', name: _tag);
      return data;
    } catch (e) {
      developer.log('Primary data error ($primaryPath): $e. Attempting recovery...', name: _tag, level: 1000);
      
      // 2. Try loading backup
      try {
        final String backupContent = await rootBundle.loadString(backupPath);
        final T backupData = json.decode(backupContent);
        developer.log('RECOVERY SUCCESS: Loaded backup data from $backupPath', name: _tag);
        return backupData;
      } catch (backupError) {
        developer.log('CRITICAL: Both primary and backup data failed for $primaryPath', name: _tag, error: backupError);
        return null;
      }
    }
  }

  /// Specialized for MCQ loading to ensure app doesn't crash
  static Future<List<dynamic>> loadMCQsSafe(String path) async {
    final result = await loadSafeJson<List<dynamic>>(path);
    return result ?? [];
  }
}
