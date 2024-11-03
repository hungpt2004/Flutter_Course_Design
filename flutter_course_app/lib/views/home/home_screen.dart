import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/views/home/widget/header.dart';
import 'package:course_app_flutter/views/home/widget/home_slide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/data/space_style.dart';
import '../../theme/data/style_button.dart';
import '../../theme/data/style_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: homeBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SpaceStyle.boxSpaceHeight(size.height * 0.1),
                SpaceStyle.boxSpaceHeight(20),
                const HeaderWidget(),
                SpaceStyle.boxSpaceHeight(20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 10),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    hintText: 'What do you learn today?',
                    hintStyle: TextStyleApp.textStyleForm(14, FontWeight.w500, Colors.grey.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    border: OutlineInputBorder(
                      gapPadding: 12,
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SpaceStyle.boxSpaceHeight(30),
                SizedBox(
                  height: size.height * 0.25,
                  child: const SlideHome(isBanner: false),
                ),
                SpaceStyle.boxSpaceHeight(10),
                ButtonStyleApp.rowButton("Trending Courses"),
                SpaceStyle.boxSpaceHeight(30),
                SizedBox(
                  height: size.height * 0.33,
                  child: const SlideHome(isBanner: true),
                ),
                SpaceStyle.boxSpaceHeight(20),
                SizedBox(
                  height: size.height * 0.15, // Đặt chiều cao cố định cho Container chứa hình ảnh
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset("assets/images/discount.png"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
