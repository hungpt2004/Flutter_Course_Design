import 'package:flutter/material.dart';
import 'package:news_app_flutter/providers/loading_provider.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import 'package:news_app_flutter/screen/auth/widget/login_social_network.dart';
import 'package:news_app_flutter/screen/auth/widget/text_input_action.dart';
import 'package:news_app_flutter/screen/start/get_started_screen.dart';
import 'package:news_app_flutter/screen/auth/register_screen.dart';
import 'package:news_app_flutter/widget/bottom_navbar/bottom_navbar_widget.dart';
import '../../theme/message_dialog.dart';
import '../../theme/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameControllerLogin =
      TextEditingController();
  final TextEditingController _passwordControllerLogin =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameControllerLogin.dispose();
    _passwordControllerLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);
    final userProvider = UserProvider.of(context);
    final loadProvider = LoadingProvider.of(context);
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
                  Style.navigatorPush(
                      context, const GetStartedScreen());
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              Style.space(8, 0),
              Center(
                child: Form(
                  key: _formKey,
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
                      LoginSocialNetwork(
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          url: "facebook.svg",
                          textControl: "Login with Facebook",
                          function: () {}),
                      Style.space(8, 0),
                      LoginSocialNetwork(
                          color: isDarkMode
                              ? Colors.white
                              : Colors.grey.withOpacity(0.1),
                          textColor: Colors.black,
                          url: "google.svg",
                          textControl: "Login with Google",
                          function: () {}),
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
                      _loginButton(context, userProvider, themeProvider, loadProvider),
                      Style.space(10, 0),
                      _signUpRow(themeProvider),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context, UserProvider userProvider,
      ThemeProvider themeProvider, LoadingProvider loadProvider) {
    return ElevatedButton(
      style: Style.ButtonStyleLoading(loadProvider.isLoading),
      onPressed: () async {
        if(_formKey.currentState!.validate()){
          await loadProvider.loading();
          bool check = await userProvider.login(context, _usernameControllerLogin.text,
              _passwordControllerLogin.text);
          if(check) {
            await loadProvider.setPageIndex(0);
            showMessageDialog(context, "Login successfully", true);
            Style.navigatorPush(context, const BottomNavbarWidget());
          } else {
            showMessageDialog(context, "Login failed", false);
          }
        }
      },
      child: loadProvider.isLoading
          ? Style.loading()
          : Style.styleContentText("Login", 20, themeProvider),
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
