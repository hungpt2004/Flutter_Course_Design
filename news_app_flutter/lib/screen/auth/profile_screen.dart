import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/loading_provider.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import 'package:news_app_flutter/widget/bottom_navbar/bottom_navbar_widget.dart';
import '../../theme/style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);
    final loadProvider = LoadingProvider.of(context);
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
                    child: Style.styleTitlePage("Profile", 40, themeProvider)),
              ),
            ),
            // Use SingleChildScrollView directly without Expanded
            SingleChildScrollView(
              child: Column(
                children: [
                  Style.space(70, 0),
                  _buildProfileImage(userProvider, isDarkTheme),
                  Style.space(30, 0),
                  _buildUserDetails(context, userProvider, themeProvider, loadProvider),
                  Style.space(50, 0),
                ],
              ),
            ),
            // Uncomment if you need the Bottom Navbar
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
                image: AssetImage(userProvider.currentUser!.urlImage),
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
            right: 120,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              color: isDarkTheme ? Colors.black : Colors.white,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  isDarkTheme ? Colors.white : primaryColors,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context, UserProvider userProvider,
      ThemeProvider themeProvider, LoadingProvider loadProvider) {
    return Column(
      children: [
        _cardInformation(
          context,
          userProvider.currentUser!.fullName,
          const Icon(Icons.person),
          themeProvider,
        ),
        _cardInformation(
          context,
          userProvider.currentUser!.email,
          const Icon(Icons.mail),
          themeProvider,
        ),
        _cardInformation(
          context,
          userProvider.currentUser!.country,
          const Icon(Icons.location_pin),
          themeProvider,
        ),
        _cardInformation(
          context,
          userProvider.currentUser!.phoneNumber,
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
        Style.space(20, 0),
        _backToHomeButton(loadProvider)
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
              onPressed: onTap,
              icon: prefixIcon,
            ),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            prefixIconColor:
                themeProvider.isDark ? Colors.white : Colors.black,
            suffixIconColor:
                themeProvider.isDark ? Colors.white : Colors.black,
            hintText: content,
            hintStyle: TextStyle(
                color: themeProvider.isDark ? Colors.white : Colors.black,
                fontSize: 14,
                fontFamily: textFontContent,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  Widget _backToHomeButton(LoadingProvider loadProvider) {
    return ElevatedButton(
        style: Style.ButtonStyleLoading(loadProvider.isLoading),
        onPressed: () async {
          await loadProvider.loading();
          await loadProvider.setPageIndex(0);
          Style.navigatorPush(context, const BottomNavbarWidget());
        },
        child: loadProvider.isLoading
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                  Style.styleContentOnCard("Back to Home", 16)
                ],
              ));
  }
}
