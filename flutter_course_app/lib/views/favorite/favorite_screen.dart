import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:course_app_flutter/views/favorite/widget/card_favorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteCourseScreen extends StatefulWidget {
  const FavoriteCourseScreen({super.key});

  @override
  State<FavoriteCourseScreen> createState() => _FavoriteCourseScreenState();
}

class _FavoriteCourseScreenState extends State<FavoriteCourseScreen> {
  @override
  Widget build(BuildContext context) {

    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    return Scaffold(
      backgroundColor: homeBackgroundColor,
      appBar: TextStyleApp.appbarStyle("Favorite Courses"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<AuthenticationProvider>(
            builder: (context, authProvider, _) {
              final favoriteCourses = authProvider.user?.favoriteCourse ?? [];
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisExtent: 250,
                  childAspectRatio: 3/2,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: favoriteCourses.length,
                itemBuilder: (context, index) {
                  final favoriteIndex = authProvider.user!.favoriteCourse[index];
                  return CardFavoriteWidget(courseID: favoriteIndex.courseID);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

