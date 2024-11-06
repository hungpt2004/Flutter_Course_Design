import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_button.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import '../../../constant/color.dart';
import '../../../theme/data/style_text.dart';

class ProfileContentWidget extends StatelessWidget {
  const ProfileContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider =
        AuthenticationProvider.stateAuthenticationProvider(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpaceStyle.boxSpaceHeight(30),
        Center(
          child: SizedBox(
              width: 200,
              height: 180,
              child: AdvancedAvatar(
                statusAlignment: Alignment.bottomRight,
                statusColor: Colors.green,
                statusSize: 20,
                size: 180,
                animated: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ImageNetworkStyle.networkImage(
                      authProvider.user?.url ?? 'assets/images/profile.png'),
                ),
              )),
        ),
        SpaceStyle.boxSpaceHeight(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              analysisContainer("Enrolling",
                  "${authProvider.user?.enrollCourse.length ?? 0}"),
              analysisContainer("Favorites",
                  "${authProvider.user?.favoriteCourse.length ?? 0}")
            ],
          ),
        ),
        SpaceStyle.boxSpaceHeight(30),
        informationText(
            "Username", authProvider.user?.username ?? 'Unknown', context),
        SpaceStyle.boxSpaceHeight(20),
        informationText(
            "Email", authProvider.user?.email ?? 'Unknown', context),
        SpaceStyle.boxSpaceHeight(20),
        informationText(
            "Password", authProvider.user?.password ?? 'Unknown', context),
        SpaceStyle.boxSpaceHeight(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: ButtonStyleApp.customerButton(() async {
            await loadingProvider.loading();
            await authProvider.credentialLogout();
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.pushNamed(context, '/auth');
            });
          }, loadingProvider, "Logout", kPrimaryColor, homeBackgroundColor),
        )
      ],
    );
  }
}

Widget informationText(String title, String text, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: kPrimaryColor,
                  ),
                  child: Center(
                      child: TextStyleApp.normalText(
                          title, 14, FontWeight.w700, kDefaultColor)),
                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: TextStyleApp.textStyleForm(
                        14, FontWeight.w500, kCardTitleColor),
                  ),
                )),
            Expanded(
              flex: 1,
                child: IconButton(
                    onPressed: () {}, icon: Icon(CupertinoIcons.pen)))
          ],
        ),
      ));
}

Widget analysisContainer(String title, String content) {
  return Card(
    elevation: 10,
    child: Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 100,
              height: 30,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: kCardTitleColor),
              child: Center(
                  child: TextStyleApp.normalText(
                      title, 16, FontWeight.w700, kDefaultColor)),
            ),
          ),
          Expanded(
            child: Center(
                child: TextStyleApp.normalText(
                    "$content courses", 14, FontWeight.w500, homeBackgroundColor)),
          )
        ],
      ),
    ),
  );
}
