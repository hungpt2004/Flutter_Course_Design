import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';

class CustomProgressbar extends StatelessWidget {
  const CustomProgressbar({super.key, required this.width, required this.height, required this.progress});

  final double width;
  final double height;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyleCustom();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
        children: [
          Container(
            width: (width*progress),
            height: height,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${progress*100.toInt()}%',
                style: textStyle.smallTextStyle(FontWeight.w600, Colors.white),
              )
            ),
          )
        ],
      ),
    );
  }
}
