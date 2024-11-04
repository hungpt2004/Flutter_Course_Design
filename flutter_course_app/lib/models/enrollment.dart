class Enrollment {
  final String id;
  final String courseID;

  Enrollment({required this.id, required this.courseID});

  factory Enrollment.fromFirebase(Map<String,dynamic> firebase, String id) {
    return Enrollment(id: id, courseID: firebase['course_id']);
  }

  Map<String,dynamic> toFirebase(){
    return {
      'course_id': courseID
    };
  }

}