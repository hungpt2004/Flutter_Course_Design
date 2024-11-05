import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/bottom_navbar_provider.dart';
import 'package:course_app_flutter/views/favorite/favorite_screen.dart';
import 'package:course_app_flutter/views/home/home_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../document/docs_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({super.key});

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {


  // Danh sách các trang
  List<Widget> pages = [
    const HomeScreen(),
    const FavoriteCourseScreen(),
    const DocumentScreen(),
    const UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {

    final bottomProvider = BottomNavbarProvider.bottomStateMangement(context);

    return Scaffold(
      body: pages[bottomProvider.currentIndex], // Hiển thị trang tương ứng với currentIndex
      backgroundColor: homeBackgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: homeBackgroundColor,
        color: kPrimaryColor,
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.fastOutSlowIn,
        onTap: (index) {
          bottomProvider.setPageIndex(index);
        },
        items: [
          SizedBox(width: 25, height: 25, child: bottomProvider.currentIndex == 0 ? Image.asset("assets/images/home1_click.png") : Image.asset("assets/images/home1.png")),
          SizedBox(width: 25, height: 25, child: bottomProvider.currentIndex == 1 ? Image.asset("assets/images/save_click.png")  : Image.asset("assets/images/save.png")),
          SizedBox(width: 25, height: 25, child: bottomProvider.currentIndex == 2 ? Image.asset("assets/images/favorite_click.png")  : Image.asset("assets/images/favorite.png")),
          SizedBox(width: 25, height: 25, child: bottomProvider.currentIndex == 3 ? Image.asset("assets/images/person_click.png")  : Image.asset("assets/images/person.png")),
        ],
      ),
    );
  }
}
