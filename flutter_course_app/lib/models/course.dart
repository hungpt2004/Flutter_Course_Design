class Course {
  final String courseId; // Document ID
  final String title;
  final String author;
  final String description;
  final double rating;
  final int totalReviews;
  final String company;
  final DateTime createdAt;
  final String url;

  Course(
      {required this.courseId,
      required this.title,
      required this.author,
      required this.description,
      required this.rating,
      required this.totalReviews,
      required this.company,
      required this.createdAt,
      required this.url});

  // Phương thức tạo đối tượng từ JSON
  factory Course.fromFirebase(Map<String, dynamic> json, String id) {
    return Course(
        courseId: id,
        title: json['title'],
        author: json['author'],
        description: json['description'],
        rating: json['rating'],
        totalReviews: json['totalReviews'],
        company: json['company'],
        createdAt: DateTime.parse(json['created_at']),
        url: json['url']);
  }

  Map<String, dynamic> toFirebase() {
    return {
      "title": title,
      "author": author,
      "description": description,
      "rating": rating,
      "totalReviews": totalReviews,
      "company": company,
      "created_at": createdAt,
      "url": url
    };
  }

}
