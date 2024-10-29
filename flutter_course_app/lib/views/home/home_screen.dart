import 'package:course_app_flutter/theme/style/space_style.dart';
import 'package:course_app_flutter/views/home/widget/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SpaceStyle.boxSpaceHeight(50),
          Header(),
        ],
      ),
    );
  }
}
