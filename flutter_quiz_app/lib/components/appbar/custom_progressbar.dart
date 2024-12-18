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
    final percentString = (progress * 100).toStringAsFixed(2); // Chuyển thành chuỗi và giới hạn 2 chữ số thập phân
    final twoDigits = percentString.split('.')[0];
    final textStyle = TextStyleCustom();
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Container(
            width: (width*progress),
            height: height,
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${int.parse(twoDigits)}%',
                style: textStyle.smallTextStyle(FontWeight.w600, Colors.white),
              )
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: width - (width*progress),
              height: height,
              decoration: BoxDecoration(
                  color: Colors.red,
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${100 - int.parse(twoDigits)}%',
                    style: textStyle.smallTextStyle(FontWeight.w600, Colors.white),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
