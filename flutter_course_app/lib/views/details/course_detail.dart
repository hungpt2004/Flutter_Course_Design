import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_button.dart';
import 'package:course_app_flutter/views/details/widget/content_widget.dart';
import 'package:course_app_flutter/views/details/widget/description_widget.dart';
import 'package:course_app_flutter/views/details/widget/video_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../provider/loading_provider.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {

    final courseProvider = CourseProvider.stateCourseManagement(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: homeBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              //VIDEO
              VideoPlayWidget(course: courseProvider.currentCourse),
              //DESCRIPTION
              SpaceStyle.boxSpaceHeight(20),
              DescriptionWidget(course: courseProvider.currentCourse),
              SpaceStyle.boxSpaceHeight(20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: ContentWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
