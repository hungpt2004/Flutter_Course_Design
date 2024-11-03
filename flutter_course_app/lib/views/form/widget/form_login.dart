import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../../theme/data/space_style.dart';
import '../../../theme/data/style_text.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLoginWidget> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void refresh(){
    _usernameController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {

    final loadProvider = LoadingProvider.stateLoadingProvider(context);
    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    return Scaffold(
        backgroundColor: kDefaultColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SpaceStyle.boxSpaceHeight(20),
              TextStyleApp.normalText(
                  "Welcome to HPLearn", 33, FontWeight.w700, kPrimaryColor),
              SpaceStyle.boxSpaceHeight(10),
              Row(
                children: [
                  Expanded(child: googleLogin(() {})),
                ],
              ),
              SpaceStyle.boxSpaceHeight(10),
              Row(
                children: [Expanded(child: facebookLogin(() {}))],
              ),
              SpaceStyle.boxSpaceHeight(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    height: 1,
                    color: Colors.grey,
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextStyleApp.normalText(
                          "or by email", 14, FontWeight.w500, kPrimaryColor),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: 1,
                    color: Colors.grey,
                  )),
                ],
              ),
              SpaceStyle.boxSpaceHeight(15),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        style: TextStyleApp.textStyleForm(16, FontWeight.w500, Colors.black),
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Username can't be empty or less than 3 character!";
                          // } else if (!RegExp(regExpEmail).hasMatch(value)) {
                          //   return "Enter with correct format :<";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hoverColor: Colors.blue,
                            labelText: 'Username',
                            labelStyle: TextStyleApp.textStyleForm(16, FontWeight.w300, kPrimaryColor),
                            hintText: 'Enter username ...',
                            hintStyle: TextStyleApp.textStyleForm(16, FontWeight.w300, kPrimaryColor),
                            errorMaxLines: 1,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kPrimaryColor, // Màu khi trường đang được chọn
                              width: 2, // Có thể điều chỉnh độ dày
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kPrimaryColor, // Màu khi trường được kích hoạt
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red, // Màu cho trạng thái lỗi
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.redAccent, // Màu khi trường lỗi và được chọn
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SpaceStyle.boxSpaceHeight(10),
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyleApp.textStyleForm(16, FontWeight.w500, Colors.black),
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Password can't be empty or less than 3 character!";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyleApp.textStyleForm(16, FontWeight.w300, kPrimaryColor),
                          hintText: 'Enter password ...',
                          hintStyle: TextStyleApp.textStyleForm(16, FontWeight.w300, kPrimaryColor),
                          errorMaxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.eye),
                          ),
                          // Đặt màu cho các trạng thái khác nhau của border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kPrimaryColor, // Màu khi trường đang được chọn
                              width: 2, // Có thể điều chỉnh độ dày
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kPrimaryColor, // Màu khi trường được kích hoạt
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red, // Màu cho trạng thái lỗi
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.redAccent, // Màu khi trường lỗi và được chọn
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SpaceStyle.boxSpaceHeight(10),
                      Row(
                        children: [Expanded(child: forgotPassword(context))],
                      ),
                      SpaceStyle.boxSpaceHeight(10),
                      loginButton(() async {
                        if(_formKey.currentState!.validate()){
                          await loadProvider.loading();
                          await authProvider.credentialLogin(_usernameController.text, _passwordController.text);
                          Navigator.pushNamed(context, "/bottom");
                        }
                      }, loadProvider),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Widget googleLogin(VoidCallback? function) {
  return SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      backgroundColor: Colors.white60.withOpacity(0.7),
      borderRadius: 15,
      onPressed: function);
}

Widget facebookLogin(VoidCallback? function) {
  return SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      borderRadius: 15,
      onPressed: function);
}

Widget forgotPassword(BuildContext context) {
  return TextButton(
    onPressed: (){
      Navigator.pushNamed(context, "/forgot");
    },
    child: TextStyleApp.normalText(
        "Forgot password?", 16, FontWeight.w500, kPrimaryColor),
  );
}

Widget loginButton(VoidCallback? function, LoadingProvider loadProvider) {
  return ElevatedButton(
      onPressed:function,
      style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(4),
          backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
          shape: WidgetStatePropertyAll( loadProvider.isLoading ?  const CircleBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          fixedSize: const WidgetStatePropertyAll(Size(396,60)),
          animationDuration: const Duration(milliseconds: 800)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: loadProvider.isLoading ? [
          const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: kDefaultColor,),)
        ] : [
          TextStyleApp.normalText(
              "Sign In", 18, FontWeight.w700, kDefaultColor),
          SpaceStyle.boxSpaceWidth(10),
          const Icon(CupertinoIcons.arrow_right,color: kDefaultColor,size: 20,)
        ],
      ));
}
