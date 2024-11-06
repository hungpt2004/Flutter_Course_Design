import 'package:flutter/material.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import '../../../constant/constant.dart';
import '../../../providers/theme_provider.dart';

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

  @override
  Widget build(BuildContext context) {

    final userProvider = UserProvider.of(context);
    final themeProvider = ThemeProvider.of(context);

    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.label} can't not be empty";
        } else {
          return null;
        }
      },
      controller: widget.controller,
      obscureText: widget.isPassword ? !userProvider.isObsecure : false,
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
            !userProvider.isObsecure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            userProvider.seePassword();
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