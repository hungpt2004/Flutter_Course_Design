class CompletedQuiz {
  final int userId;
  final int quizId;
  final int score;
  final DateTime? completedAt;  // Thay đổi từ String thành DateTime
  final DateTime? paidAt;  // Thay đổi từ String thành DateTime

  CompletedQuiz({
    required this.userId,
    required this.quizId,
    required this.score,
    this.completedAt,  // Cập nhật kiểu DateTime
    this.paidAt,  // Cập nhật kiểu DateTime
  });

  // Chuyển đổi từ Map thành CompletedQuiz
  factory CompletedQuiz.fromMap(Map<String, dynamic> map) {
    return CompletedQuiz(
      userId: map['user_id'],
      quizId: map['quiz_id'],
      score: map['score'],
      completedAt: DateTime.parse(map['completed_at']),  // Chuyển từ String thành DateTime
      paidAt: DateTime.parse(map['paid_at']),  // Chuyển từ String thành DateTime
    );
  }

  // Chuyển đổi CompletedQuiz thành Map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'quiz_id': quizId,
      'score': score,
      'completed_at': completedAt!.toIso8601String(),  // Chuyển từ DateTime thành String
      'paid_at': paidAt!.toIso8601String(),  // Chuyển từ DateTime thành String
    };
  }
}
