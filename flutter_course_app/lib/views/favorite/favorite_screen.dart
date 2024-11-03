import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteCourseScreen extends StatefulWidget {
  const FavoriteCourseScreen({super.key});

  @override
  State<FavoriteCourseScreen> createState() => _FavoriteCourseScreenState();
}

class _FavoriteCourseScreenState extends State<FavoriteCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: homeBackgroundColor,
        appBar: TextStyleApp.appbarStyle("Favorite Courses"),
        body:  Center(
          child: Text("Favorite Page"),
        ),
      );
  }
}
