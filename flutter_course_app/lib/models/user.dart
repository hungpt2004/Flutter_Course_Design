import 'enrollment.dart';
import 'favorite.dart';

class User {
  final String userId; // ID người dùng
  final String username; // Tên người dùng
  final String email; // Địa chỉ email
  final String password; // Mật khẩu (nên mã hóa trong thực tế)
  final DateTime createdAt; // Thời gian tạo tài khoản
  final String url;
  List<Enrollment> enrollCourse;
  List<Favorite> favoriteCourse;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.url,
    this.enrollCourse = const [],
    this.favoriteCourse = const []
  });

  // Phương thức để chuyển đổi từ JSON thành đối tượng User
  factory User.fromFirebase(Map<String, dynamic> json, String id,{List<Enrollment> enrollments = const [], List<Favorite> favorites = const []}) {
    return User(
      userId: id,
      username: json['username'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']),
      url: json['url'],
      enrollCourse: enrollments,
      favoriteCourse: favorites
    );
  }

  // Phương thức để chuyển đổi từ đối tượng User thành JSON
  Map<String, dynamic> toFirebase() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'url': url
    };
  }
}
