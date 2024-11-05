import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../provider/loading_provider.dart';

class ButtonStyleApp {
  static Widget backButton(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Colors.white60.withOpacity(0.5)),
            foregroundColor: const WidgetStatePropertyAll(kPrimaryColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            elevation: const WidgetStatePropertyAll(3)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 5),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: kPrimaryColor,
          ),
        ));
  }

  static Widget customerButton(VoidCallback? function,
      LoadingProvider loadProvider, String text, Color color, Color textColor) {
    return ElevatedButton(
        onPressed: function,
        style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(4),
            backgroundColor: WidgetStatePropertyAll(color),
            shape: WidgetStatePropertyAll(loadProvider.isLoading
                ? const CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            fixedSize: const WidgetStatePropertyAll(Size(396, 60)),
            animationDuration: const Duration(milliseconds: 800)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: loadProvider.isLoading
              ? [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: textColor,
                    ),
                  )
                ]
              : [
                  TextStyleApp.normalText(text, 18, FontWeight.w700, textColor),
                  SpaceStyle.boxSpaceWidth(10),
                ],
        ));
  }

  static Widget normalButton(
      VoidCallback? function,
      String text,
      Color color,
      Color colorInside,
      Color textColor,
      double border,
      double padding,
      double elevation) {
    return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
          elevation: WidgetStatePropertyAll(elevation),
          backgroundColor: WidgetStatePropertyAll(color),
          foregroundColor: WidgetStatePropertyAll(colorInside),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border))),
          animationDuration: const Duration(milliseconds: 800),
          padding: WidgetStatePropertyAll(EdgeInsets.all(padding))),
      child: TextStyleApp.normalText(text, 14, FontWeight.w700, textColor),
    );
  }
  
  static Widget rowButton(String content){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextStyleApp.normalText(content, 16, FontWeight.w500, kCardTitleColor),
        InkWell(
          onTap: () {},
          child: TextStyleApp.underlineText("See all", 14, FontWeight.w500, kPrimaryColor),
        )
      ],
    );
  }
  
}
