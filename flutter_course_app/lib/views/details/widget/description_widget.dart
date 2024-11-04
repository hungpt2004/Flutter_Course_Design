import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/models/favorite.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/material.dart';
import '../../../models/course.dart';
import '../../../theme/data/style_toast.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    final authProvider =
        AuthenticationProvider.stateAuthenticationProvider(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.orange.withOpacity(0.9)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                    child: Text(
                      course.company,
                      style: TextStyleApp.textStyleForm(
                          24, FontWeight.w700, kPrimaryColor),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await authProvider.addFavoriteCourse(
                        authProvider.user!.userId,
                        Favorite(id: '', courseID: course.courseId));
                    await authProvider.getAllFavorite(authProvider.user!.userId);
                  },
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset("assets/images/save_click.png"),
                  ))
            ],
          ),
          SpaceStyle.boxSpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleApp.normalText(
                  "⭐ ${course.rating}  (${course.totalReviews} views)",
                  14,
                  FontWeight.w500,
                  Colors.white60),
              TextStyleApp.normalText(
                  "🕔 ${course.time}", 14, FontWeight.w500, Colors.white60),
            ],
          ),
          SpaceStyle.boxSpaceHeight(10),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  children: [
                    Text(
                      course.description,
                      style: TextStyleApp.textStyleForm(
                          14, FontWeight.w500, Colors.white60),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
