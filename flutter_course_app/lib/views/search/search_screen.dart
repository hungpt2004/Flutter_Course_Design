import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCourseScreen extends StatefulWidget {
  const SearchCourseScreen({super.key});

  @override
  State<SearchCourseScreen> createState() => _SearchCourseScreenState();
}

class _SearchCourseScreenState extends State<SearchCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Search Screen"),
      ),
    );
  }
}
