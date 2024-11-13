import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:course_app_flutter/views/home/widget/header.dart';
import 'package:course_app_flutter/views/home/widget/home_slide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../../provider/course_provider.dart';
import '../../theme/data/space_style.dart';
import '../../theme/data/style_button.dart';
import '../../theme/data/style_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final courseProvider = CourseProvider.stateCourseManagement(context);

    return SafeArea(
      child: Scaffold(
          backgroundColor: homeBackgroundColor,
          body: FutureBuilder<void>(
              future: courseProvider.fetchAllCourses(),
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SpaceStyle.boxSpaceHeight(20,context),
                        const HeaderWidget(),
                        SpaceStyle.boxSpaceHeight(20,context),
                        TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          onChanged: (value) {
                            if (_searchController.text.isEmpty) {
                              courseProvider.endToggleSearch();
                            } else {
                              for (var c in courseProvider.courses) {
                                if (c.title
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  courseProvider.toggleSearch(c);
                                }
                              }
                            }
                          },
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 10),
                              child: Icon(
                                CupertinoIcons.search,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                            hintText: 'What do you learn today?',
                            hintStyle: TextStyleApp.textStyleForm(14,
                                FontWeight.w500, Colors.grey.withOpacity(0.5)),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            border: OutlineInputBorder(
                              gapPadding: 12,
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        if (courseProvider.suggestionCourse.isNotEmpty)
                          Container(
                            width: StyleSize(context).widthPercent(StyleSize(context).figmaWidth * 0.75),
                            height: StyleSize(context).heightPercent(180),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                              color: Colors.grey.withOpacity(0.5)
                            ),
                            child: ListView.builder(
                                itemCount:
                                    courseProvider.suggestionCourse.length,
                                itemBuilder: (context, index) {
                                  final courseIndex =
                                      courseProvider.suggestionCourse[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: ListTile(
                                      focusColor: kPrimaryColor,
                                      style: ListTileStyle.drawer,
                                      leading: SizedBox(
                                        width: StyleSize(context).widthPercent(80),
                                        height: StyleSize(context).heightPercent(40),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                            child:
                                                ImageNetworkStyle.networkImage(
                                                    courseIndex.logo)),
                                      ),
                                      title: Text(
                                        courseIndex.title,
                                        style: TextStyleApp.textStyleForm(14,
                                            FontWeight.w500, kCardTitleColor),
                                      ),
                                      onTap: () async {
                                        await courseProvider.setCurrentCourse(courseIndex);
                                        Navigator.pushNamed(context, "/detail");
                                      },
                                    ),
                                  );
                                }),
                          ),
                        SpaceStyle.boxSpaceHeight(30,context),
                        SizedBox(
                          height: StyleSize(context).heightPercent(StyleSize(context).figmaHeight * 0.25),
                          child: const SlideHome(isBanner: false),
                        ),
                        SpaceStyle.boxSpaceHeight(10,context),
                        ButtonStyleApp.rowButton("Trending Courses"),
                        SpaceStyle.boxSpaceHeight(30,context),
                        SizedBox(
                          height: StyleSize(context).heightPercent(StyleSize(context).figmaHeight * 0.33),
                          child: const SlideHome(isBanner: true),
                        ),
                        SpaceStyle.boxSpaceHeight(20,context),
                        SizedBox(
                          height: StyleSize(context).heightPercent(StyleSize(context).figmaHeight * 0.15), // Đặt chiều cao cố định cho Container chứa hình ảnh
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                        "assets/images/discount.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
