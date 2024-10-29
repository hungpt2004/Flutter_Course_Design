import 'package:course_app_flutter/constant/font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


  static Widget tabviewText(String content, double size, FontWeight weight) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        fontFamily: textFont,
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

}