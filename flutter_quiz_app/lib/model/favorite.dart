class Favorite {
  int? id;
  int quizId;
  int userId;
  final DateTime createdAt;
  Favorite({this.id, required this.userId,required this.quizId,required this.createdAt});
  Map<String, dynamic> toMap(){
    return {
      'quiz_id' : quizId,
      'user_id' : userId,
      'created_at' : createdAt.toIso8601String()
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(id: map['id'], quizId: map['quiz_id'],userId: map['user_id'], createdAt: map['created_at']);
  }

}