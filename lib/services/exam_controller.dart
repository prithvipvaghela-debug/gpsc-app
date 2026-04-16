import 'dart:async';
import 'package:flutter/material.dart';
import '../models/user_progress.dart';
import '../models/quiz_question.dart';
import '../services/auto_save_service.dart';

enum QuestionStatus {
  notVisited,
  notAnswered,
  answered,
  markedForReview,
}

/// Senior Architect Exam Controller (Optimized)
/// Uses granular state updates to minimize UI rebuilds.
class ExamController extends ChangeNotifier {
  final List<QuizQuestion> questions;
  final String examId;
  final int totalDurationSeconds;

  // Granular Notifiers for performance
  final ValueNotifier<int> timeLeft = ValueNotifier<int>(0);
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);
  
  late List<int?> selectedAnswers;
  late List<bool> markedForReview;
  late List<bool> visited;
  
  Timer? _timer;
  bool isSubmitted = false;

  ExamController({
    required this.questions,
    required this.examId,
    this.totalDurationSeconds = 3600,
  }) {
    timeLeft.value = totalDurationSeconds;
    selectedAnswers = List<int?>.filled(questions.length, null);
    markedForReview = List<bool>.filled(questions.length, false);
    visited = List<bool>.filled(questions.length, false);
    visited[0] = true;
    
    _loadFromHive();
  }

  void _loadFromHive() {
    for (int i = 0; i < questions.length; i++) {
      final key = 'exam_${examId}_q$i';
      final progress = AutoSaveService().getProgress(key);
      if (progress != null) {
        selectedAnswers[i] = progress.selectedAnswerIndex;
        visited[i] = true;
        markedForReview[i] = progress.isBookmarked;
      }
    }
    notifyListeners();
  }

  void startTimer(VoidCallback onTimeUp) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        onTimeUp();
      }
    });
  }

  void selectAnswer(int questionIndex, int? answerIndex) {
    selectedAnswers[questionIndex] = answerIndex;
    _saveToHive(questionIndex);
    notifyListeners(); // Rebuilds palette and current question options
  }

  void toggleMarkForReview(int questionIndex) {
    markedForReview[questionIndex] = !markedForReview[questionIndex];
    _saveToHive(questionIndex);
    notifyListeners();
  }

  void jumpToQuestion(int index) {
    if (index < 0 || index >= questions.length) return;
    currentIndex.value = index;
    visited[index] = true;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      jumpToQuestion(currentIndex.value + 1);
    }
  }

  void previousQuestion() {
    if (currentIndex.value > 0) {
      jumpToQuestion(currentIndex.value - 1);
    }
  }

  void _saveToHive(int index) {
    final key = 'exam_${examId}_q$index';
    AutoSaveService().saveProgress(UserProgress(
      questionId: key,
      selectedAnswerIndex: selectedAnswers[index],
      isBookmarked: markedForReview[index],
      isAttempted: selectedAnswers[index] != null,
    ));
  }

  QuestionStatus getStatus(int index) {
    if (markedForReview[index]) return QuestionStatus.markedForReview;
    if (selectedAnswers[index] != null && selectedAnswers[index] != -1) return QuestionStatus.answered;
    if (visited[index]) return QuestionStatus.notAnswered;
    return QuestionStatus.notVisited;
  }

  // Optimized getters
  int get attemptedCount => selectedAnswers.where((a) => a != null && a != -1).length;
  int get markedCount => markedForReview.where((m) => m).length;
  int get unattemptedCount => questions.length - attemptedCount;

  /// High-performance result calculation moved from UI to Controller
  Map<String, dynamic> calculateResults() {
    int correctCount = 0;
    int wrongCount = 0;
    double score = 0;
    const double correctMark = 1.0;
    const double wrongMark = 0.33;

    for (int i = 0; i < questions.length; i++) {
      final selected = selectedAnswers[i];
      if (selected != null && selected != -1) {
        if (selected == questions[i].correctAnswerIndex) {
          correctCount++;
          score += correctMark;
        } else {
          wrongCount++;
          score -= wrongMark;
        }
      }
    }

    return {
      'score': score,
      'correct': correctCount,
      'wrong': wrongCount,
    };
  }

  @override
  void dispose() {
    _timer?.cancel();
    timeLeft.dispose();
    currentIndex.dispose();
    super.dispose();
  }
}
