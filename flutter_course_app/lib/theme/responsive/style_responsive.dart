import 'package:flutter/cupertino.dart';

class StyleSize {
  final BuildContext context;

  StyleSize(this.context);

  final double figmaWidth = 412;
  final double figmaHeight = 915;

  // GETTER
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  // METHOD
  double widthPercent(double size) => (screenWidth / figmaWidth) * size;
  double heightPercent(double size) => (screenHeight / figmaHeight) * size;
}
