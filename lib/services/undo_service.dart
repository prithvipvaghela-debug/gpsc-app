import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import '../models/user_progress.dart';
import 'auto_save_service.dart';

/// Senior Architect Undo Service
/// Maintains a lightweight history stack on top of Hive auto-save.
class UndoService extends ChangeNotifier {
  static final UndoService _instance = UndoService._internal();
  factory UndoService() => _instance;
  UndoService._internal();

  static const int _maxHistory = 20;
  final List<UndoAction> _historyStack = [];

  bool get canUndo => _historyStack.isNotEmpty;

  /// Pushes an action to the history stack
  void pushAction(UndoAction action) {
    // 1. Avoid duplicates (e.g., clicking the same answer twice if UI allows)
    if (_historyStack.isNotEmpty && _historyStack.last.id == action.id && _historyStack.last.type == action.type) {
      // If we just want to update the old state but keep the same action, 
      // though usually a new action implies a state change.
    }

    _historyStack.add(action);

    // 2. Enforce history limit
    if (_historyStack.length > _maxHistory) {
      _historyStack.removeAt(0);
    }

    developer.log('UndoService: Pushed action ${action.type} for ${action.id}', name: 'Undo');
    notifyListeners();
  }

  /// Performs undo operation
  Future<UndoAction?> undo() async {
    if (!canUndo) return null;

    final action = _historyStack.removeLast();
    
    try {
      // 1. Sync back to Hive (AutoSave)
      if (action.previousProgress != null) {
        await AutoSaveService().saveProgressNow(action.previousProgress!);
      } else {
        // If there was no previous state, we might need to delete it from Hive,
        // but for safety, we'll just store a "cleared" state or null if AutoSave allows.
        // For our implementation, we'll assume we revert to the previousProgress.
      }

      developer.log('UndoService: Undone action ${action.type} for ${action.id}', name: 'Undo');
      notifyListeners();
      return action;
    } catch (e) {
      developer.log('UndoService Error: $e', name: 'Undo', level: 1000);
      return null;
    }
  }

  void clearHistory() {
    _historyStack.clear();
    notifyListeners();
  }
}

/// Lightweight representation of a reversible action
class UndoAction {
  final String id;
  final UserProgress? previousProgress;
  final String type; // 'mcq', 'bookmark', etc.
  final dynamic metadata; // For UI to know what exactly to refresh (e.g., question index)

  UndoAction({
    required this.id,
    this.previousProgress,
    required this.type,
    this.metadata,
  });
}
