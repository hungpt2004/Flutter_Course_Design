import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/models/enrollment.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_button.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:course_app_flutter/views/details/widget/content_widget.dart';
import 'package:course_app_flutter/views/details/widget/description_widget.dart';
import 'package:course_app_flutter/views/details/widget/video_widget.dart';
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
    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: kCardTitleColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // VIDEO
              VideoPlayWidget(course: courseProvider.currentCourse),
              // DESCRIPTION
              SpaceStyle.boxSpaceHeight(20,context),
              DescriptionWidget(course: courseProvider.currentCourse),
              SpaceStyle.boxSpaceHeight(20,context),
              SizedBox(
                height: StyleSize(context).heightPercent(StyleSize(context).figmaHeight * 0.32),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: ContentWidget(),
                ),
              ),
              SizedBox(
                width: StyleSize(context).widthPercent(StyleSize(context).figmaWidth * 0.5),
                child: ButtonStyleApp.customerButton(() async {
                  await loadingProvider.loading();

                  await authProvider.checkStatusEnroll(
                    authProvider.user!.userId,
                    courseProvider.currentCourse.courseId,
                  );

                  print(authProvider.buttonText);

                  if (authProvider.buttonText == 'Enroll') {
                    // Attempt to enroll
                    await authProvider.joinCourse(
                      authProvider.user!.userId,
                      Enrollment(id: '', courseID: courseProvider.currentCourse.courseId),
                    );
                  } else {
                    // Attempt to leave
                    await authProvider.leaveCourse(
                      authProvider.user!.userId,
                      courseProvider.currentCourse.courseId,
                    );
                  }

                }, loadingProvider, authProvider.buttonText, kDefaultColor, kPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
