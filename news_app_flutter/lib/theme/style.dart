import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../providers/theme_provider.dart';
import '../widget/route/slide_page_route_widget.dart';

class Style {

  static Widget space(double height, double width){
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // static TextStyle
  static Widget styleContentText(String text, double size, ThemeProvider themeProvider){
    return Text(
      text,
      style: TextStyle(
          color: themeProvider.isDark ? Colors.white : Colors.black,
          fontSize: size,
          fontFamily: textFontContent,
          fontWeight: FontWeight.w400
      ),
    );
  }

  static Widget styleTitleText(String text, double size, ThemeProvider themeProvider){
    return Text(
      text,
      style: TextStyle(
          color: themeProvider.isDark ? Colors.white : primaryColors,
          fontSize: size,
          fontFamily: textFontTitle,
          fontWeight: FontWeight.w700
      ),
    );
  }

  static Widget styleContentOnCard(String text, double size){
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.white,
          fontSize: size,
          fontFamily: textFontContent,
          fontWeight: FontWeight.w400
      ),
    );
  }

  static Widget styleTitleOnCard(String text, double size){
    return Text(
      text,
      style:  TextStyle(
          color:Colors.white,
          fontSize: size,
          fontFamily: textFontTitle,
          fontWeight: FontWeight.w700
      ),
    );
  }

  static Widget styleTitlePage(String text, double size, ThemeProvider themeProvider){
    return Text(
      text,
      style: TextStyle(
          color: themeProvider.isDark ? Colors.white : primaryColors,
          fontSize: size,
          fontFamily: textFontTitle,
          fontWeight: FontWeight.w700
      ),
    );
  }


  static void navigatorPush(BuildContext context, Widget page){
    Navigator.push(
        context,
        SlidePageRoute(
            page: page,
            beginOffset: const Offset(1, 0),
            endOffset: Offset.zero,
            duration: const Duration(milliseconds: 500)));
  }

  static double styleWidthDevice(BuildContext context){
      return MediaQuery.of(context).size.width;
  }

  static double styleHeightDevice(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static ButtonStyleLoading(bool isLoad){
    return ButtonStyle(
        visualDensity: const VisualDensity(horizontal: 2, vertical: 2),
        backgroundColor: const WidgetStatePropertyAll(primaryColors),
        shape: WidgetStatePropertyAll(
          isLoad
              ? const CircleBorder()
              : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)),
        ),
        shadowColor: const WidgetStatePropertyAll(Colors.black),
        animationDuration: const Duration(milliseconds: 800),
        fixedSize: const WidgetStatePropertyAll(Size(200, 30)),
        elevation: const WidgetStatePropertyAll(4));
  }

  static Widget loading(){
    return const SizedBox(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }

  static Widget networkImage(String url){
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CircularProgressIndicator(
              color: primaryColors,
              value: downloadProgress.progress),),
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(CupertinoIcons.info_circle),
        );
      },
      fadeInDuration: const Duration(milliseconds: 300),
      fadeInCurve: Curves.easeInOut,
    );
  }

  static Widget snapshotLoading(ThemeProvider themeProvider) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: primaryColors,),
          Style.space(0, 10),
          Style.styleContentText("Loading...", 14, themeProvider)
        ],
      ),
    );
  }

  static Widget snapshotError(ThemeProvider themeProvider) {
    return Center(
      child: Style.styleContentText("Error when fetch data", 14, themeProvider),
    );
  }

  static Widget snapshotDataNull(ThemeProvider themeProvider) {
    return Center(
      child: Style.styleContentText("No data", 14, themeProvider),
    );
  }

}