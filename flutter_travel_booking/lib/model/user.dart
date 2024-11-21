import 'package:flutter_travel_booking/model/post.dart';

class User {
  int id;
  String username;
  String password;
  String email;
  String? country;
  String phone;
  String? gender;
  String dob;
  List<Post> posts;
  String memberType;
  String? avatar; // URL ảnh đại diện

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.country,
    required this.phone,
    this.gender,
    required this.dob,
    this.posts = const [],
    required this.memberType,
    this.avatar, // Mặc định là null nếu không được cung cấp
  });
}

List<User> usersList = [
  User(
    id: 1,
    username: 'Hùng Pham',
    password: 'password123',
    email: 'john.doe@example.com',
    country: 'Viet Nam',
    phone: '+1234567890',
    gender: 'Male',
    dob: '1990-01-01',
    posts: postsList.where((p) => p.userId == 1).toList(),
    memberType: 'Premium',
    avatar: 'https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg',
  ),
  User(
    id: 2,
    username: 'Công Minh',
    password: 'securepass456',
    email: 'jane.smith@example.com',
    country: 'United Kingdom',
    phone: '+9876543210',
    gender: 'Female',
    dob: '1992-05-15',
    posts: postsList.where((p) => p.userId == 2).toList(),
    memberType: 'Standard',
    avatar: 'https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg',
  ),
  User(
    id: 3,
    username: 'NguyenLKH',
    password: 'travel@2023',
    email: 'travel.guy@example.com',
    country: 'Canada',
    phone: '+14325567890',
    gender: 'Male',
    dob: '1985-11-20',
    posts: postsList.where((p) => p.userId == 3).toList(),
    memberType: 'Standard',
    avatar: 'https://sm.ign.com/ign_ap/cover/a/avatar-gen/avatar-generations_hugw.jpg',
  ),
  User(
    id: 4,
    username: 'Hung234',
    password: 'queen@adventure',
    email: 'adventure.queen@example.com',
    country: 'Australia',
    phone: '+61234567890',
    gender: 'Female',
    dob: '1995-06-10',
    posts:postsList.where((p) => p.userId == 4).toList(),
    memberType: 'Premium',
    avatar: 'https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=1200&h=1200&rs=1&pid=ImgDetMain',
  ),
  User(
    id: 5,
    username: '子田ロ引く',
    password: 'kotarohiku@2023',
    email: 'kotarohiku@example.com',
    country: 'Japan',
    phone: '+493012345678',
    gender: 'Male',
    dob: '1990-03-25',
    posts: postsList.where((p) => p.userId == 5).toList(),
    memberType: 'Standard',
    avatar: 'https://th.bing.com/th/id/OIP.EwG6x9w6RngqsKrPJYxULAHaHa?w=1200&h=1200&rs=1&pid=ImgDetMain',
  ),
];
