import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/style/space_style.dart';
import 'package:course_app_flutter/theme/style/style_button.dart';
import 'package:course_app_flutter/theme/style/style_text.dart';
import 'package:course_app_flutter/views/home/widget/header.dart';
import 'package:course_app_flutter/views/home/widget/home_slide.dart';
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
    final size = MediaQuery.of(context).size; // Lấy kích thước màn hình

    return Scaffold(
      backgroundColor: homeBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SpaceStyle.boxSpaceHeight(size.height * 0.1), // 10% chiều cao màn hình
              const HeaderWidget(),
              SpaceStyle.boxSpaceHeight(size.height * 0.05), // 5% chiều cao màn hình
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
              SpaceStyle.boxSpaceHeight(size.height * 0.05), // 5% chiều cao màn hình
              SizedBox(
                height: size.height * 0.25, // 25% chiều cao màn hình
                child: const SlideHome(isBanner: false),
              ),
              SpaceStyle.boxSpaceHeight(size.height * 0.05), // 5% chiều cao màn hình
              ButtonStyleApp.rowButton("Trending Courses"),
              SpaceStyle.boxSpaceHeight(size.height * 0.05), // 5% chiều cao màn hình
              SizedBox(
                height: size.height * 0.35, // 35% chiều cao màn hình
                child: const SlideHome(isBanner: true),
              ),
              SpaceStyle.boxSpaceHeight(size.height * 0.05), // 5% chiều cao màn hình
              Expanded(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
