import 'package:course_app_flutter/constant/font.dart';
import 'package:flutter/material.dart';
import '../../constant/color.dart';

class TextStyleApp {

  static Widget normalText(String content, double size, FontWeight weight, Color color) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color, // Sử dụng màu đen nếu không có màu nào được chỉ định
        fontFamily: textFont,
      ),
    );
  }

  static Widget underlineText(String content, double size, FontWeight weight, Color color){
    return SelectableText(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        decoration: TextDecoration.underline,
        decorationColor: color,
        fontSize: size,
        fontWeight: weight,
        color: color, // Sử dụng màu đen nếu không có màu nào được chỉ định
        fontFamily: textFont,
      ),
    );
  }

  static Widget tabviewText(String content, double size, FontWeight weight) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: textFont,
        color: Colors.white60
      ),
    );
  }

  static TextStyle textStyleForm(double size, FontWeight weight, Color color){
    return TextStyle(
      fontFamily: textFont,
      fontWeight: weight,
      fontSize: size,
      color: color
    );
  }


  static AppBar appbarStyle(String text) {
    return AppBar(
      elevation: 10,
      backgroundColor: kPrimaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
      ),
      centerTitle: true,
      title: TextStyleApp.normalText(text, 30, FontWeight.w500, homeBackgroundColor),
    );
  }

}