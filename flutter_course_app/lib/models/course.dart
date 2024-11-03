import 'package:course_app_flutter/models/video.dart';

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
  final List<Video> videos;

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
      required this.url,
      required this.videos
      });

  // Phương thức tạo đối tượng từ JSON
  factory Course.fromFirebase(Map<String, dynamic> firebase, String id, List<Video> videos) {
    return Course(
        courseId: id,
        title: firebase['title'] ?? 'Flutter',
        author: firebase['author'] ?? 'null',
        description: firebase['description'] ?? 'This course provides a foundational understanding of Ruby, a dynamic and expressive programming language. Ideal for beginners, it covers essential programming concepts and object-oriented principles !',
        logo: firebase['logo'] ??
            'https://www.mindinventory.com/blog/wp-content/uploads/2022/10/flutter-3.png',
        rating: firebase['rating'],
        time: firebase['time'],
        totalReviews: firebase['totalReviews'],
        company: firebase['company'] ?? 'null',
        createdAt: DateTime.parse(firebase['created_at'] ?? 'null'),
        url: firebase['url'],
        videos: videos
    );
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
