class Favorite {
  final String id;
  final String courseID;

  Favorite({required this.id, required this.courseID});

  Map<String,dynamic> toFirebase() {
    return {
      'course_id':courseID
    };
  }

  factory Favorite.fromFirebase(Map<String,dynamic> firebase, String id) {
    return Favorite(id: id, courseID: firebase['course_id']);
  }

}