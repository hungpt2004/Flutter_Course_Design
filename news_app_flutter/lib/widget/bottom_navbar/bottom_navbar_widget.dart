import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/providers/loading_provider.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/screen/auth/profile_screen.dart';
import 'package:news_app_flutter/screen/details/favourite_news_screen.dart';
import 'package:news_app_flutter/screen/details/history_news_screen.dart';
import '../../constant/constant.dart';
import '../../screen/home_screen.dart';

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({super.key});

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {

  List<Widget> pages = [
    const HomeScreen(),
    const FavouriteNewsScreen(),
    const HistoryNewsScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final loadProvider = LoadingProvider.of(context);
    final themeProvider = ThemeProvider.of(context);

    return Scaffold(
      body: pages[loadProvider
          .currentIndex],
      backgroundColor: themeProvider.isDark ? Colors.black : Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: themeProvider.isDark ? Colors.black : Colors.white,
        color: primaryColors,
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.fastOutSlowIn,
        onTap: (index) {
          loadProvider.setPageIndex(index);
        },
        items: [
          SizedBox(
              width: 25,
              height: 25,
              child: loadProvider.currentIndex == 0
                  ? const Icon(EvaIcons.home,color: Colors.white,)
                  : const Icon(EvaIcons.home,color: Colors.black38,)),
          SizedBox(
              width: 25,
              height: 25,
              child: loadProvider.currentIndex == 1
                  ? const Icon(EvaIcons.heart,color: Colors.white,)
                  : const Icon(EvaIcons.heart,color: Colors.black38,)),
          SizedBox(
              width: 25,
              height: 25,
              child: loadProvider.currentIndex == 2
                  ? const Icon(EvaIcons.refreshOutline,color: Colors.white,)
                  : const Icon(EvaIcons.refreshOutline,color: Colors.black38,)),
          SizedBox(
              width: 25,
              height: 25,
              child: loadProvider.currentIndex == 3
                  ? const Icon(EvaIcons.person,color: Colors.white,)
                  : const Icon(EvaIcons.person,color: Colors.black38,)),
        ],
      ),
    );
  }
}
