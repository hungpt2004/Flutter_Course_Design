import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import 'package:news_app_flutter/screen/details/history_news_screen.dart';
import 'package:news_app_flutter/widget/slide_page_route_widget.dart';

import '../../widget/bottom_navbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);
    final userProvider = UserProvider.of(context);
    // print(userProvider.currentUser.urlImage);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 5,
                right: 0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: themeProvider.isDark
                          ? Colors.black
                          : Colors.transparent),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          Navigator.pop(context),
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, top: 10, bottom: 10, right: 5),
                          child: Center(
                              child: Icon(
                            Icons.arrow_back_ios,
                            color: themeProvider.isDark
                                ? Colors.white
                                : Colors.black,
                          )),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          "Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: textFontContent,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                              color: themeProvider.isDark
                                  ? Colors.white
                                  : primaryColors),
                        ),
                      ),

                      // Same width as the back arrow padding
                      const SizedBox(
                        width: 48,
                      ),
                    ],
                  ),
                )),
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Center(
                    child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "${userProvider.currentUser.urlImage}"),
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: themeProvider.isDark
                                    ? Colors.white
                                    : Colors.red.withOpacity(0.5),
                                width: 3)),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 140,
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: themeProvider.isDark
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    themeProvider.isDark
                                        ? Colors.white
                                        : primaryColors),
                              ),
                            )
                          ],
                        ))
                  ],
                )),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    child: _cardInformation(
                        context,
                        "${userProvider.currentUser.fullName}",
                        Icon(Icons.person),
                        () {},
                        () {},
                        themeProvider.isDark
                            ? Colors.transparent
                            : Colors.black,
                        themeProvider.isDark
                            ? Colors.transparent
                            : Colors.black,
                        themeProvider.isDark ? Colors.white : Colors.black,
                        false)),
                _cardInformation(
                    context,
                    "${userProvider.currentUser.email}",
                    Icon(Icons.mail),
                    () {},
                    () {},
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.white : Colors.black,
                    false),
                _cardInformation(
                    context,
                    "${userProvider.currentUser.password}",
                    Icon(Icons.key),
                    () {},
                    () {},
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.white : Colors.black,
                    true),
                _cardInformation(context, "${userProvider.currentUser.country}", Icon(Icons.location_pin),
                    () {},
                    () {},
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.white : Colors.black,
                    false),
                _cardInformation(
                    context,
                    "${userProvider.currentUser.phoneNumber}",
                    Icon(Icons.phone_enabled),
                    () {},
                    () {},
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.white : Colors.black,
                    false),
                _cardInformation(
                    context,
                    "Logout",
                    Icon(Icons.logout),
                    () {
                      userProvider.logout(context);
                    },
                    () {},
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.transparent : Colors.black,
                    themeProvider.isDark ? Colors.white : Colors.black,
                    false)
              ],
            ),
            const BottomNavbarWidget(
              indexStaying: 3,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _cardInformation(
    BuildContext context,
    String content,
    Icon prefixIcon,
    Function prefixFunction,
    Function suffixFunction,
    Color prefixIconColor,
    Color suffixIconColor,
    Color textColor,
    bool isPassword) {
  TextEditingController _controller = TextEditingController();
  _controller.text = content;
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(15), boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 2,
              offset: Offset(0, 3))
        ]),
        child: TextField(
          controller: _controller,
          obscureText: isPassword ? true : false,
          readOnly: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              prefixIcon: IconButton(
                  onPressed: () {
                    prefixFunction();
                  },
                  icon: prefixIcon),
              suffixIcon: IconButton(
                  onPressed: () {
                    suffixFunction();
                  },
                  icon: Icon(Icons.edit)),
              prefixIconColor: prefixIconColor,
              suffixIconColor: suffixIconColor,
              hintText: content,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: textFontContent,
                  color: textColor,
                  fontSize: 20)),
        ),
      ),
    ),
  );
}
