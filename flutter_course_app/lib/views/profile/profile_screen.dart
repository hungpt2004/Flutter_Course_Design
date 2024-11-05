import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:course_app_flutter/views/profile/widget/profile_content_widget.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBackgroundColor,
      appBar: TextStyleApp.appbarStyle("Profile Users"),
      body: const ProfileContentWidget()
    );
  }
}
