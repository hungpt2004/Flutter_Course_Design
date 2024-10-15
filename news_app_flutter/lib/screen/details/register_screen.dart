import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';

import '../../model/user.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  bool? isMale;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _fullnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);
    final userProvider = UserProvider.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios)),
                  ],
                ),
                _text("SIGN UP", 30, textFontTitle, FontWeight.w700, themeProvider.isDark ? primaryColors : Colors.black),
                const SizedBox(
                  height: 8,
                ),
                _loginSocialNetwork(context, Colors.blueAccent, Colors.white,
                    "facebook.svg", "Sign up with Facebook", () {}),
                const SizedBox(
                  height: 8,
                ),
                _loginSocialNetwork(context, themeProvider.isDark ? Colors.white : Colors.grey.withOpacity(0.1),
                    Colors.black, "google.svg", "Sign up with Google", () {}),
                const SizedBox(
                  height: 8,
                ),
                _loginSocialNetwork(context,themeProvider.isDark ? Colors.white : Colors.grey.withOpacity(0.1),
                    Colors.black, "apple.svg", "Sign up with Apple", () {}),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 1,
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: _text("or login with email", 14, textFontContent, FontWeight.w400, themeProvider.isDark ? Colors.white : Colors.black),
                      ),
                      Expanded(
                          child: Divider(
                            color: Colors.grey.withOpacity(0.5),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _TextInputActionWidget(
                    controller: _usernameController,
                    hinttext: "Enter username",
                    label: "Username",
                    icon: const Icon(Icons.person),
                    isPassword: false),
                const SizedBox(
                  height: 8,
                ),
                _TextInputActionWidget(
                    controller: _passwordController,
                    hinttext: "Enter password",
                    label: "Password",
                    icon: const Icon(Icons.key),
                    isPassword: true),
                const SizedBox(
                  height: 8,
                ),
                _TextInputActionWidget(
                    controller: _fullnameController,
                    hinttext: "Enter fullname",
                    label: "Fullname",
                    icon: const Icon(Icons.drive_file_rename_outline),
                    isPassword: false),
                const SizedBox(
                  height: 8,
                ),
                _TextInputActionWidget(
                    controller: _phoneController,
                    hinttext: "Enter phone number",
                    label: "PhoneNumber",
                    icon: const Icon(Icons.phone_in_talk),
                    isPassword: false),
                const SizedBox(
                  height: 8,
                ),
                _TextInputActionWidget(
                    controller: _emailController,
                    hinttext: "Enter email",
                    label: "Email",
                    icon: const Icon(Icons.email),
                    isPassword: false),
                const SizedBox(
                  height: 8,
                ),
                _TextInputActionWidget(
                    controller: _countryController,
                    hinttext: "Enter country",
                    label: "Country",
                    icon: const Icon(Icons.location_pin),
                    isPassword: false),
                const SizedBox(
                  height: 8,
                ),

                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text("Male"),
                        value: true,
                        groupValue: isMale,
                        onChanged: (bool? value) {
                          setState(() {
                            isMale = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: Text("Female"),
                        value: false,
                        groupValue: isMale,
                        onChanged: (bool? value) {
                          setState(() {
                            isMale = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        visualDensity: const VisualDensity(horizontal: 3, vertical: 4),
                        backgroundColor: const WidgetStatePropertyAll(primaryColors),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                        animationDuration: const Duration(milliseconds: 2000),
                        shadowColor: const WidgetStatePropertyAll(Colors.black),
                        fixedSize: WidgetStatePropertyAll(Size.fromWidth(MediaQuery.of(context).size.width))
                    ),
                    onPressed: () {
                      bool gender = isMale ?? true;
                      userProvider.addUsers(context, User("${userProvider.users.length+1}",_usernameController.text, _passwordController.text, _fullnameController.text, "assets/images/user4.jpg",_phoneController.text,_emailController.text,_countryController.text,gender));
                    },
                    child: _text("SIGN UP", 25, textFontContent, FontWeight.w600,
                        Colors.white)
                ),
                SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _loginSocialNetwork(BuildContext context, Color color, Color textColor,
    String url, String text, Function function) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color),
          color: color),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset("assets/images/$url", height: 100),
            ),
            _text(text, 18, textFontContent, FontWeight.w400, textColor)
          ],
        ),
      ),
    ),
  );
}

Widget _text(
    String text, double size, String textFont, FontWeight weight, Color color) {
  return Text(text,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: textFont,
          fontWeight: weight));
}

class _TextInputActionWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hinttext;
  final String label;
  final Icon icon;
  final bool isPassword;

  const _TextInputActionWidget({
    Key? key,
    required this.controller,
    required this.hinttext,
    required this.label,
    required this.icon,
    required this.isPassword,
  }) : super(key: key);

  @override
  _TextInputActionWidgetState createState() => _TextInputActionWidgetState();
}

class _TextInputActionWidgetState extends State<_TextInputActionWidget> {
  bool isObserve = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? isObserve : !isObserve,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: TextStyle(
            fontFamily: textFontContent,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: themeProvider.isDark ? Colors.white : Colors.black),
        label: Text(widget.label),
        labelStyle: TextStyle(
            fontFamily: textFontContent,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: themeProvider.isDark ? Colors.white : Colors.black),
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
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
