import 'package:flutter/cupertino.dart';
import 'package:flutter_travel_booking/theme/response/response_size.dart';

class BoxSpace {

  //Space responsive width
  Widget spaceWidth(double width, BuildContext context) {
    return SizedBox(
      width: StyleSize(context).widthPercent(width),
    );
  }

  //Space responsive height
  Widget spaceHeight(double height, BuildContext context) {
    return SizedBox(
      height: StyleSize(context).heightPercent(height),
    );
  }

}