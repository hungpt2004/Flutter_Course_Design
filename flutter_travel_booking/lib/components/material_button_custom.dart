import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';

import '../theme/color/color.dart';
import '../theme/text/font_size.dart';

class AndroidButtonCustom extends StatelessWidget {
  AndroidButtonCustom({super.key, required this.text, required this.function, required this.borderRadius, required this.color, required this.textColor});

  final String text;
  final VoidCallback function;
  final double borderRadius;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyleCustom();

    return MaterialButton(
        onPressed: function,
        elevation: 8,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        hoverElevation: 15,
        color: color,
        child: Text(
          text,
          style: textStyle.textStyleForm(
              themeFontSizeSmall,
              FontWeight.w400,
              textColor),
        ));
  }
}
