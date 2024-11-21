import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';

import '../../../theme/color/color.dart';
import '../../../theme/response/response_size.dart';

class ButtonEventWidget extends StatelessWidget {
  ButtonEventWidget({super.key, required this.url, required this.text, required this.function});
  VoidCallback? function;
  String url;
  String text;

  final TextStyleCustom textStyleCustom = TextStyleCustom();
  final BoxSpace boxSpace = BoxSpace();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Card(
            elevation: 15,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/vectors/$url',fit: BoxFit.cover,),
                ),
              )
            ),
          ),
          boxSpace.spaceHeight(5, context),
          Text(text,textAlign:TextAlign.center,style: textStyleCustom.textStyleForm(12, FontWeight.w400, Colors.black),)
        ],
      ),
    );
  }
}
