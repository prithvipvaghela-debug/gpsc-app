import 'package:hive/hive.dart';

part 'user_progress.g.dart';

@HiveType(typeId: 0)
class UserProgress extends HiveObject {
  @HiveField(0)
  final String questionId;
  
  @HiveField(1)
  final int? selectedAnswerIndex;
  
  @HiveField(2)
  final bool isBookmarked;
  
  @HiveField(3)
  final bool isAttempted;
  
  @HiveField(4)
  final DateTime timestamp;

  UserProgress({
    required this.questionId,
    this.selectedAnswerIndex,
    this.isBookmarked = false,
    this.isAttempted = false,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': questionId,
      'answer': selectedAnswerIndex,
      'bookmarked': isBookmarked,
      'attempted': isAttempted,
      'ts': timestamp.millisecondsSinceEpoch,
    };
  }

  factory UserProgress.fromMap(Map<dynamic, dynamic> map) {
    return UserProgress(
      questionId: map['id'] as String,
      selectedAnswerIndex: map['answer'] as int?,
      isBookmarked: map['bookmarked'] as bool? ?? false,
      isAttempted: map['attempted'] as bool? ?? false,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['ts'] as int? ?? DateTime.now().millisecondsSinceEpoch),
    );
  }

  UserProgress copyWith({
    int? selectedAnswerIndex,
    bool? isBookmarked,
    bool? isAttempted,
  }) {
    return UserProgress(
      questionId: questionId,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isAttempted: isAttempted ?? this.isAttempted,
      timestamp: DateTime.now(),
    );
  }
}
