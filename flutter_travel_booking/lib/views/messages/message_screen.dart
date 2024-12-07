import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travel_booking/components/material_button_custom.dart';
import 'package:flutter_travel_booking/model/message_button.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';
import 'package:flutter_travel_booking/theme/space/space.dart';
import 'package:flutter_travel_booking/theme/text/font_size.dart';
import 'package:flutter_travel_booking/theme/text/text_style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../theme/color/color.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boxSpace = BoxSpace();
    final textStyle = TextStyleCustom();

    alertClean() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 15,
            alignment: Alignment.center,
            backgroundColor: white,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            content: Text(
              'Mark all messages as read?',
              textAlign: TextAlign.center,
              style: textStyle.textStyleForm(
                  themeFontSizeBig, FontWeight.w500, Colors.black),
            ),
            actions: [
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AndroidButtonCustom(
                        text: 'Not Now',
                        function: () => Navigator.pop(context),
                        borderRadius: 5,
                        color: lightBlue,
                        textColor: white),
                    AndroidButtonCustom(
                        text: 'Yes',
                        function: () => (),
                        borderRadius: 5,
                        color: lightBlue,
                        textColor: white)
                  ],
                ),
              )
            ],
          ));
    }


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                lightBlue.withOpacity(0.4),
                white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.01, 0.38]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              // H E A D E R
              _header(textStyle, context, boxSpace, () {alertClean();}),

              // S E T T I N G -- MSG
              _settingBanner(context,textStyle),

              boxSpace.spaceHeight(10, context),

              // B O O K I N G -- NOTI
              _bookingNotification(context,textStyle),
              //
              // // M E M B E R -- TYPE
              // _memberType()
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(TextStyleCustom textStyle, BuildContext context, BoxSpace boxSpace, VoidCallback cleanFunction) {
    return SizedBox(
      width: StyleSize(context).screenWidth,
      height: StyleSize(context).heightPercent(80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Messages",
                    style: textStyle.textStyleForm(
                        themeFontSizeTitle, FontWeight.w600, Colors.black)),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.yellow.shade800),
                )
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: cleanFunction,
                child: SvgPicture.asset(
                  'assets/vectors/clean.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              boxSpace.spaceWidth(10, context),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/vectors/support.svg',
                  width: 25,
                  height: 25,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _settingBanner(BuildContext context, TextStyleCustom textStyle) {
    return Card(
      elevation: 15,
      child: Container(
        width: StyleSize(context).screenWidth,
        height: 100,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: msgButtonList.length,
            itemBuilder: (context,index){
              final buttonIndex = msgButtonList[index];
              return Container(
                margin: EdgeInsets.only(right: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: buttonIndex.color.withOpacity(0.3)
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset('assets/vectors/${buttonIndex.url}',width: 25,height: 25,),
                      ),
                    ),
                    Text(buttonIndex.title,
                        style: textStyle.textStyleForm(
                            themeFontSizeSmall, FontWeight.w400, Colors.black))
                  ],
                ),
              );
            },
          ),
        )
      ),
    );
  }


  Widget _bookingNotification(BuildContext context, TextStyleCustom textStyle) {
    return Card(
      elevation: 15,
      child: Container(
        width: StyleSize(context).screenWidth,
        height: 80,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10,right: 15),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF95B3DE).withOpacity(0.3)
              ),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset('assets/vectors/doc.svg',width: 20,height: 20,),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No Booking Notifications',style: textStyle.textStyleForm(themeFontSizeMedium, FontWeight.w500, Colors.black),),
                  Text('You can find booking notifications from the past 6 months here after making a payment',style: textStyle.textStyleForm(themeFontSizeSmall, FontWeight.w400, Colors.grey),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _memberType() {
    return Container();
  }
}
