import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_button.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:course_app_flutter/theme/data/style_toast.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:provider/provider.dart';
import '../../../constant/color.dart';
import '../../../theme/data/style_text.dart';

class ProfileContentWidget extends StatefulWidget {
  const ProfileContentWidget({super.key});

  @override
  State<ProfileContentWidget> createState() => _ProfileContentWidgetState();
}

class _ProfileContentWidgetState extends State<ProfileContentWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        AuthenticationProvider.stateAuthenticationProvider(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);
    final _formKey = GlobalKey<FormState>();
    _usernameController.text = authProvider.user!.username;
    _emailController.text = authProvider.user!.email;
    _passwordController.text = authProvider.user!.password;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpaceStyle.boxSpaceHeight(30, context),
            _circleAvatar(authProvider, loadingProvider, context),
            SpaceStyle.boxSpaceHeight(20, context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _analysisContainer("Enrolling",
                      "${authProvider.user?.enrollCourse.length ?? 0}", context),
                  _analysisContainer("Favorites",
                      "${authProvider.user?.favoriteCourse.length ?? 0}", context)
                ],
              ),
            ),
            SpaceStyle.boxSpaceHeight(30, context),
            _informationText("Username", authProvider.user!.username, context,
                authProvider, _usernameController, true),
            SpaceStyle.boxSpaceHeight(20, context),
            _informationText("Email", authProvider.user!.email, context,
                authProvider, _emailController, true),
            SpaceStyle.boxSpaceHeight(20, context),
            Consumer<AuthenticationProvider>(
              builder: (context, auth, child) {
                return _informationText("Password", auth.user!.password, context,
                    auth, _passwordController,false);
              },
            ),
            SpaceStyle.boxSpaceHeight(10, context),
            if (authProvider.readOnly)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                child: Column(
                  children: [
                    _informationText("Confirm Password", '', context,
                        authProvider, _rePasswordController, false),
                    SpaceStyle.boxSpaceHeight(10, context),
                    ButtonStyleApp.normalButton(() async {
                      if (_rePasswordController.text.trim() ==
                          _passwordController.text.trim()) {
                        await authProvider.changePassword(
                            authProvider.user!.email, _passwordController.text);
                        await authProvider.changeInformation();
                        _rePasswordController.clear();
                      } else {
                        ToastStyle.toastFail("Password are different !");
                      }
                    }, "Save Changes", kCardTitleColor, homeBackgroundColor,
                        homeBackgroundColor, 15, 10, 10),
                  ],
                ),
              ),
            SpaceStyle.boxSpaceHeight(10, context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: ButtonStyleApp.customerButton(() async {
                await loadingProvider.loading();
                await authProvider.credentialLogout();
                Future.delayed(const Duration(milliseconds: 300), () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/auth',
                    (Route<dynamic> route) => false,
                  );
                });
              }, loadingProvider, "Logout", kPrimaryColor, homeBackgroundColor),
            )
          ],
        ),
      ),
    );
  }
}

Widget _informationText(
    String title,
    String text,
    BuildContext context,
    AuthenticationProvider authProvider,
    TextEditingController controller,
    bool isPassword) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: StyleSize(context).screenWidth,
        height: StyleSize(context).heightPercent(50),
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
                  child: authProvider.readOnly
                      ? TextFormField(
                          readOnly: isPassword,
                          controller: controller,
                          style: TextStyleApp.textStyleForm(
                              14, FontWeight.w500, kCardTitleColor),
                          validator: (value) {
                            if (value == null || value.length < 3) {
                              return "Can't not be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        )
                      : Text(
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
                    onPressed: () {}, icon: const Icon(CupertinoIcons.pen)))
          ],
        ),
      ));
}

Widget _analysisContainer(String title, String content, BuildContext context) {
  return Card(
    elevation: 10,
    child: Container(
      width: StyleSize(context).widthPercent(100),
      height: StyleSize(context).heightPercent(70),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: StyleSize(context).widthPercent(100),
              height: StyleSize(context).heightPercent(30),
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
                child: TextStyleApp.normalText("$content courses", 14,
                    FontWeight.w500, homeBackgroundColor)),
          )
        ],
      ),
    ),
  );
}

Widget _circleAvatar(AuthenticationProvider authProvider,
    LoadingProvider loadProvider, BuildContext context) {
  return Center(
    child: SizedBox(
        width: StyleSize(context).widthPercent(200),
        height: StyleSize(context).heightPercent(220),
        child: Column(
          children: [
            AdvancedAvatar(
              statusAlignment: Alignment.bottomRight,
              statusColor: Colors.green,
              statusSize: 20,
              size: 150,
              animated: true,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ImageNetworkStyle.networkImage(
                    authProvider.user?.url ?? 'assets/images/profile.png'),
              ),
            ),
            SpaceStyle.boxSpaceHeight(10, context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonStyleApp.normalButton(() {}, 'Upload', kPrimaryColor,
                    homeBackgroundColor, homeBackgroundColor, 10, 10, 10),
                SpaceStyle.boxSpaceWidth(10, context),
                ButtonStyleApp.normalButton(() async {
                  await authProvider.changeInformation();
                }, 'Setting', kPrimaryColor, homeBackgroundColor,
                    homeBackgroundColor, 10, 10, 10)
              ],
            )
          ],
        )),
  );
}
