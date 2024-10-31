class Course {
  final String courseId; // Document ID
  final String title;
  final String author;
  final String description;
  final String logo;
  final double rating;
  final int totalReviews;
  final String company;
  final DateTime createdAt;
  final String time;
  final String url;

  Course(
      {required this.courseId,
      required this.title,
      required this.author,
      required this.description,
      required this.logo,
      required this.rating,
      required this.totalReviews,
      required this.company,
      required this.createdAt,
      required this.time,
      required this.url});

  // Phương thức tạo đối tượng từ JSON
  factory Course.fromFirebase(Map<String, dynamic> firebase, String id) {
    return Course(
        courseId: id,
        title: firebase['title'] ?? 'Flutter',
        author: firebase['author'] ?? 'null',
        description: firebase['description'] ?? 'null',
        logo: firebase['logo'] ??
            'https://www.mindinventory.com/blog/wp-content/uploads/2022/10/flutter-3.png',
        rating: firebase['rating'],
        time: firebase['time'],
        totalReviews: firebase['totalReviews'],
        company: firebase['company'] ?? 'null',
        createdAt: DateTime.parse(firebase['created_at'] ?? 'null'),
        url: firebase['url']);
  }

  Map<String, dynamic> toFirebase() {
    return {
      "title": title,
      "author": author,
      "description": description,
      "logo": logo,
      "rating": rating,
      "totalReviews": totalReviews,
      "company": company,
      "time":time,
      "created_at": createdAt.toIso8601String(),
      "url": url
    };
  }
}
