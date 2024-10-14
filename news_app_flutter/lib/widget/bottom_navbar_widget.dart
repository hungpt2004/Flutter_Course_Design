import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/screen/details/favourite_news_screen.dart';
import 'package:news_app_flutter/screen/details/history_news_screen.dart';
import 'package:news_app_flutter/screen/home_screen.dart';
import 'package:news_app_flutter/screen/details/profile_screen.dart';

import '../constant/constant.dart';

class BottomNavbarWidget extends StatefulWidget {
  const BottomNavbarWidget({super.key, required this.indexStaying});

  final int indexStaying;

  @override
  State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
}

class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
  @override
  Widget build(BuildContext context) {
    int select = widget.indexStaying;

    void togglePage(int index) {
      setState(() {
        select = index;
      });
    }

    return bottomNavbar(context, togglePage, select);
  }
}

Widget bottomNavbar(BuildContext context, Function function, int selected) {
  return Positioned(
    bottom: 20,
    left: 0,
    right: 0,
    child: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        function(0);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.home,
                        color: selected == 0 ? primaryColors : Colors.grey,
                      ),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: textFontContent,
                        fontWeight: FontWeight.w300,
                        color: selected == 0 ? primaryColors : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        function(1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavouriteNewsScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: selected == 1 ? primaryColors : Colors.grey,
                      ),
                    ),
                    Text(
                      "Favourite",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: textFontContent,
                        fontWeight: FontWeight.w300,
                        color: selected == 1 ? primaryColors : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        function(2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryNewsScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.history,
                        color: selected == 2 ? primaryColors : Colors.grey,
                      ),
                    ),
                    Text(
                      "History",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: textFontContent,
                        fontWeight: FontWeight.w300,
                        color: selected == 2 ? primaryColors : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        function(2);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                        color: selected == 3 ? primaryColors : Colors.grey,
                      ),
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: textFontContent,
                        fontWeight: FontWeight.w300,
                        color: selected == 3 ? primaryColors : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
