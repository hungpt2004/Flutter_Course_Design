import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import 'package:news_app_flutter/widget/bottom_navbar_widget.dart';

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

    final isDarkTheme = themeProvider.isDark;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: !themeProvider.isDark ? Colors.white : Colors.black12,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: textFontTitle,
                      fontSize: 40,
                      color: themeProvider.isDark ? Colors.white : primaryColors,
                      shadows: CupertinoContextMenu.kEndBoxShadow,
                    ),
                  ),
                ),
              ),
            ),
            // Positioned Back Button
            Positioned(
              top: 10,
              left: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: themeProvider.isDark ? Colors.white : Colors.black,),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    _buildProfileImage(userProvider, isDarkTheme),
                    const SizedBox(height: 10),
                    _buildUserDetails(context, userProvider, themeProvider),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            // const BottomNavbarWidget(indexStaying: 3),
          ],
        ),
      ),
    );
  }



  Widget _buildProfileImage(UserProvider userProvider, bool isDarkTheme) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(userProvider.currentUser.urlImage),
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkTheme ? Colors.white : Colors.red.withOpacity(0.5),
                width: 3,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 140,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              color: isDarkTheme ? Colors.black : Colors.white,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  isDarkTheme ? Colors.white : primaryColors,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context, UserProvider userProvider, ThemeProvider themeProvider) {

    return Column(
      children: [
        _cardInformation(
          context,
          userProvider.currentUser.fullName,
          const Icon(Icons.person),
          themeProvider,
        ),
        _cardInformation(
          context,
          userProvider.currentUser.email,
          const Icon(Icons.mail),
          themeProvider,
        ),
        _cardInformation(
          context,
          userProvider.currentUser.country,
          const Icon(Icons.location_pin),
          themeProvider,
        ),
        _cardInformation(
          context,
          userProvider.currentUser.phoneNumber,
          const Icon(Icons.phone_enabled),
          themeProvider,
        ),
        _cardInformation(
          context,
          "Logout",
          const Icon(Icons.logout),
          themeProvider,
          onTap: () => userProvider.logout(context),
        ),
      ],
    );
  }

  Widget _cardInformation(
    BuildContext context,
    String content,
    Icon prefixIcon,
    ThemeProvider themeProvider, {
    bool isPassword = false,
    Function()? onTap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          obscureText: isPassword,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: prefixIcon,
            ),
            suffixIcon: IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.edit),
            ),
            prefixIconColor: themeProvider.isDark ? Colors.transparent : Colors.black,
            suffixIconColor: themeProvider.isDark ? Colors.transparent : Colors.black,
            hintText: content,
            hintStyle: TextStyle(
                color: themeProvider.isDark ? Colors.white : Colors.black,
                fontSize: 14,
                fontFamily: textFontContent,
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}
