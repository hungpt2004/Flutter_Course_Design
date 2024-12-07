class Question {
  final int? id;
  final String imageUrl;
  final String description;
  final String content;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final int correctAnswer;
  final int quizId;

  Question({
    this.id,
    required this.imageUrl,
    required this.description,
    required this.content,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
    required this.quizId,
  });

  // Chuyển đổi từ Map thành Question
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'],
      imageUrl: map['image_url'],
      description: map['description'],
      content: map['content'],
      answer1: map['answer1'],
      answer2: map['answer2'],
      answer3: map['answer3'],
      answer4: map['answer4'],
      correctAnswer: map['correct_answer'],
      quizId: map['quiz_id'],
    );
  }

  // Chuyển đổi Question thành Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image_url': imageUrl,
      'description': description,
      'content': content,
      'answer1': answer1,
      'answer2': answer2,
      'answer3': answer3,
      'answer4': answer4,
      'correct_answer': correctAnswer,
      'quiz_id': quizId,
    };
  }
}
