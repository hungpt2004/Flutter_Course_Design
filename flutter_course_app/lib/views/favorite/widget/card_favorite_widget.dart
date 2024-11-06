import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/models/course.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/data/style_button.dart';

class CardFavoriteWidget extends StatelessWidget {
  const CardFavoriteWidget({super.key, required this.courseID});

  final String courseID;

  @override
  Widget build(BuildContext context) {

    final courseProvider = CourseProvider.stateCourseManagement(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);
    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    return FutureBuilder<Course?>(
      future: courseProvider.getCourseByID(courseID),
      builder: (context, snapshot) {
        // Kiểm tra trạng thái kết nối và dữ liệu trong snapshot
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: kDefaultColor,));
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading course data'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Course not found'));
        }

        Course course = snapshot.data!;

        return Consumer<AuthenticationProvider>(
          builder: (context, authProvider, _) {
            return Card(
              elevation: 15,
              color: kCardTitleColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ImageNetworkStyle.networkImage(course.logo),
                      ),
                    ),
                  ),
                  SpaceStyle.boxSpaceHeight(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      course.title,
                      style: TextStyleApp.textStyleForm(14, FontWeight.w700, kDefaultColor),
                    ),
                  ),
                  SpaceStyle.boxSpaceHeight(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      course.company,
                      style: TextStyleApp.textStyleForm(14, FontWeight.w500, kDefaultColor),
                    ),
                  ),
                  SpaceStyle.boxSpaceHeight(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "⭐ ${course.rating}  (${course.totalReviews} views)",
                      style: TextStyleApp.textStyleForm(14, FontWeight.w500, kDefaultColor),
                    ),
                  ),
                  Center(
                    child: ButtonStyleApp.normalButton(() async {
                      await loadingProvider.loading();
                      await authProvider.removeFavoriteCourse(authProvider.user!.userId,courseID);
                      await authProvider.getAllFavorite(authProvider.user!.userId);
                    }, "Remove", Colors.redAccent, kDefaultColor, kDefaultColor, 15, 10, 10),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

