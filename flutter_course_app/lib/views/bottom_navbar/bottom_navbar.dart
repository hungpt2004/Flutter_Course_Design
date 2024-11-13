import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/bottom_navbar_provider.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
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

    final bottomProvider = BottomNavbarProvider.bottomStateManagement(context);

    return Scaffold(
      body: pages[bottomProvider.currentIndex],
      backgroundColor: homeBackgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        height: StyleSize(context).heightPercent(60),
        backgroundColor: homeBackgroundColor,
        color: kPrimaryColor,
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.fastOutSlowIn,
        onTap: (index) {
          bottomProvider.setPageIndex(index);
        },
        items: [
          _buttonNavbar(0, "assets/images/home1_click.png", "assets/images/home1.png", bottomProvider, context),
          _buttonNavbar(1, "assets/images/save_click.png", "assets/images/save.png", bottomProvider, context),
          _buttonNavbar(2, "assets/images/favorite_click.png", "assets/images/favorite.png", bottomProvider, context),
          _buttonNavbar(3, "assets/images/person_click.png", "assets/images/person.png", bottomProvider, context),
        ],
      ),
    );
  }
}

Widget _buttonNavbar(int index, String urlAction, String urlNonAction, BottomNavbarProvider bottomProvider, BuildContext context){
  return SizedBox(
    width: StyleSize(context).widthPercent(25),
    height: StyleSize(context).heightPercent(25),
    child: bottomProvider.currentIndex == index ? Image.asset(urlAction) : Image.asset(urlNonAction),
  );
}