import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';

import '../../model/user.dart';
import '../../theme/style.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
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
                _buildBackButton(context),
                _buildTitle(themeProvider),
                const SizedBox(height: 8),
                _buildSocialLoginButtons(context, themeProvider),
                const SizedBox(height: 15),
                _buildDividerWithText(context, themeProvider, "or login with email"),
                const SizedBox(height: 15),
                _buildTextFields(),
                _buildGenderSelection(),
                const SizedBox(height: 15),
                _buildSignUpButton(context, userProvider,themeProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ],
    );
  }

  Widget _buildTitle(ThemeProvider themeProvider) {
    return Style.styleTitleText(
      "SIGN UP",
      30, themeProvider
    );
  }

  Widget _buildSocialLoginButtons(BuildContext context, ThemeProvider themeProvider) {
    return Column(
      children: [
        loginSocialNetwork(context, Colors.blueAccent, Colors.white, "facebook.svg", "Sign up with Facebook", () {},themeProvider),
        const SizedBox(height: 8),
        loginSocialNetwork(context, themeProvider.isDark ? Colors.white : Colors.grey.withOpacity(0.1), Colors.black, "google.svg", "Sign up with Google", () {},themeProvider),
      ],
    );
  }

  Widget _buildDividerWithText(BuildContext context, ThemeProvider themeProvider, String textControl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: Colors.grey.withOpacity(0.5), thickness: 1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Style.styleContentText(textControl, 14,themeProvider),
          ),
          Expanded(
            child: Divider(color: Colors.grey.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        TextInputActionWidget(
          controller: _usernameController,
          hinttext: "Enter username",
          label: "Username",
          icon: const Icon(Icons.person),
          isPassword: false,
        ),
        const SizedBox(height: 8),
        TextInputActionWidget(
          controller: _passwordController,
          hinttext: "Enter password",
          label: "Password",
          icon: const Icon(Icons.key),
          isPassword: true,
        ),
        const SizedBox(height: 8),
        TextInputActionWidget(
          controller: _fullnameController,
          hinttext: "Enter fullname",
          label: "Fullname",
          icon: const Icon(Icons.drive_file_rename_outline),
          isPassword: false,
        ),
        const SizedBox(height: 8),
        TextInputActionWidget(
          controller: _phoneController,
          hinttext: "Enter phone number",
          label: "PhoneNumber",
          icon: const Icon(Icons.phone_in_talk),
          isPassword: false,
        ),
        const SizedBox(height: 8),
        TextInputActionWidget(
          controller: _emailController,
          hinttext: "Enter email",
          label: "Email",
          icon: const Icon(Icons.email),
          isPassword: false,
        ),
        const SizedBox(height: 8),
        TextInputActionWidget(
          controller: _countryController,
          hinttext: "Enter country",
          label: "Country",
          icon: const Icon(Icons.location_pin),
          isPassword: false,
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Expanded(
          child: RadioListTile<bool>(
            title: const Text("Male"),
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
            title: const Text("Female"),
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
    );
  }

  Widget _buildSignUpButton(BuildContext context, UserProvider userProvider, ThemeProvider themeProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 5), backgroundColor: primaryColors,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 48),
      ),
      onPressed: () {
        bool gender = isMale ?? true;
        userProvider.addUsers(
          context,
          User(
            "${userProvider.users.length + 1}",
            _usernameController.text,
            _passwordController.text,
            _fullnameController.text,
            "assets/images/user4.jpg",
            _phoneController.text,
            _emailController.text,
            _countryController.text,
            gender,
          ),
        );
      },
      child: Style.styleContentText("SIGN UP", 18, themeProvider),
    );
  }
}

