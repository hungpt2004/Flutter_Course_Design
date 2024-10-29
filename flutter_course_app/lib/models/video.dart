class Video {
  final String videoId; // Document ID
  final String title;
  final String url;
  final int duration;
  final int order;
  final String courseId; // Khóa ngoại liên kết đến khóa học

  Video({
    required this.videoId,
    required this.title,
    required this.url,
    required this.duration,
    required this.order,
    required this.courseId,
  });

  // Phương thức tạo đối tượng từ JSON
  factory Video.fromFirebase(Map<String, dynamic> json, String id) {
    return Video(
      videoId: id,
      title: json['title'],
      url: json['url'],
      duration: json['duration'],
      order: json['order'],
      courseId: json['course_id'],
    );
  }
}
