import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import 'package:news_app_flutter/screen/start/get_started_screen.dart';
import 'package:news_app_flutter/screen/auth/register_screen.dart';
import 'package:news_app_flutter/widget/route/slide_page_route_widget.dart';

import '../../theme/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameControllerLogin = TextEditingController();
  final TextEditingController _passwordControllerLogin = TextEditingController();
  bool isLoad = false;

  @override
  void dispose() {
    _usernameControllerLogin.dispose();
    _passwordControllerLogin.dispose();
    super.dispose();
  }

  _startLoad() async {
    setState(() {
      isLoad = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoad = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final userProvider = UserProvider.of(context);
    final isDarkMode = themeProvider.isDark;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    SlidePageRoute(
                      page: GetStartedScreen(isDark: isDarkMode),
                      beginOffset: const Offset(0, 1),
                      endOffset: Offset.zero,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Style.space(8, 0),
              Center(
                child: Column(
                  children: [
                    Style.styleTitleText(
                      "WELCOME TO NEWSPULSES",
                      25,
                      themeProvider,
                    ),
                    Style.styleContentText(
                      "Login and Sign up to access your account",
                      14,
                      themeProvider,
                    ),
                    Style.space(20, 0),
                    Style.styleTitleText(
                      "LOGIN",
                      25,
                      themeProvider,
                    ),
                    Style.space(8, 0),
                    loginSocialNetwork(
                        context,
                        Colors.blueAccent,
                        Colors.white,
                        "facebook.svg",
                        "Login with Facebook",
                        () {},
                        themeProvider),
                    Style.space(8, 0),
                    loginSocialNetwork(
                        context,
                        isDarkMode
                            ? Colors.white
                            : Colors.grey.withOpacity(0.1),
                        Colors.black,
                        "google.svg",
                        "Login with Google",
                        () {},
                        themeProvider),
                    Style.space(15, 0),
                    _dividerWithText("or login with email", themeProvider),
                    Style.space(15, 0),
                    TextInputActionWidget(
                      controller: _usernameControllerLogin,
                      hinttext: "Enter username",
                      label: "Username",
                      icon: const Icon(Icons.person),
                      isPassword: false,
                    ),
                    Style.space(20, 0),
                    TextInputActionWidget(
                      controller: _passwordControllerLogin,
                      hinttext: "Enter password",
                      label: "Password",
                      icon: const Icon(Icons.key),
                      isPassword: true,
                    ),
                    Style.space(10, 0),
                    TextButton(
                      onPressed: () {},
                      child: Style.styleContentText(
                        "Forgot Password?",
                        15,
                        themeProvider,
                      ),
                    ),
                    Style.space(10, 0),
                    _loginButton(context, userProvider, themeProvider),
                    Style.space(10, 0),
                    _signUpRow(themeProvider),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context, UserProvider userProvider,
      ThemeProvider themeProvider) {
    return ElevatedButton(
      style: ButtonStyle(
        visualDensity: const VisualDensity(horizontal: 2, vertical: 2),
        backgroundColor: const WidgetStatePropertyAll(primaryColors),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
        shadowColor: const WidgetStatePropertyAll(Colors.black),
        fixedSize: WidgetStatePropertyAll(Size.fromWidth(MediaQuery.of(context).size.width * 0.4),),
      ),
      onPressed: () async {
        await _startLoad();
        userProvider.login(context, _usernameControllerLogin.text,
            _passwordControllerLogin.text);
      },
      child: isLoad ? const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: Colors.white,),) : Style.styleContentText("LOGIN", 20, themeProvider) ,
    );
  }

  Widget _signUpRow(ThemeProvider themeProvider) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Style.styleContentText(
          "Don't have an account?",
          16,
          themeProvider,
        ),
        TextButton(
          onPressed: () {
            Style.navigatorPush(context, const RegisterScreen());
          },
          child: Style.styleContentText("SIGN UP", 15, themeProvider),
        ),
      ],
    );
  }
}

Widget loginSocialNetwork(
    BuildContext context,
    Color color,
    Color textColor,
    String url,
    String textControl,
    Function function,
    ThemeProvider themeProvider) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset("assets/images/$url", height: 36),
          ),
          const SizedBox(width: 10),
          Style.styleContentText(textControl, 18, themeProvider),
        ],
      ),
    ),
  );
}

Widget _dividerWithText(String textControl, ThemeProvider themeProvider) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 1,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Style.styleContentText(
          textControl,
          14,
          themeProvider,
        ),
      ),
      Expanded(
        child: Divider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 1,
        ),
      ),
    ],
  );
}


class TextInputActionWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hinttext;
  final String label;
  final Icon icon;
  final bool isPassword;
  // final formKey;

  const TextInputActionWidget({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.label,
    required this.icon,
    required this.isPassword,
    // required this.formKey
  });

  @override
  TextInputActionWidgetState createState() => TextInputActionWidgetState();
}

class TextInputActionWidgetState extends State<TextInputActionWidget> {
  bool isObserve = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    return TextFormField(
      validator: (value) {
        if (value == null || value.length == 0) {
          return "${widget.label} can't not be empty";
        } else {
          return "null";
        }
      },
      controller: widget.controller,
      obscureText: widget.isPassword ? isObserve : !isObserve,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: TextStyle(
            color: themeProvider.isDark ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: textFontContent,
            fontWeight: FontWeight.w400
        ),
        labelText: widget.label,
        labelStyle: TextStyle(
            color: themeProvider.isDark ? Colors.white : Colors.black,
            fontSize: 14,
            fontFamily: textFontContent,
            fontWeight: FontWeight.w400
        ),
        prefixIcon: widget.icon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObserve ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isObserve = !isObserve;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
