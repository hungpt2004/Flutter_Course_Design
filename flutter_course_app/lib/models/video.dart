class Video {
  final String videoId; // Document ID
  final String title;
  final String url;
  final int duration;
  final int order;

  Video({
    required this.videoId,
    required this.title,
    required this.url,
    required this.duration,
    required this.order,
  });

  // Phương thức tạo đối tượng từ JSON
  factory Video.fromFirebase(Map<String, dynamic> firebase, String id) {
    return Video(
      videoId: id,
      title: firebase['title'],
      url: firebase['url'],
      duration: firebase['duration'],
      order: firebase['order'],
    );
  }
}
