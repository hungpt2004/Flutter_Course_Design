import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:flutter/cupertino.dart';

class SpaceStyle {

  static SizedBox boxSpaceWidth(double w, BuildContext context){
    return SizedBox(
      width: StyleSize(context).widthPercent(w),
    );
  }

  static SizedBox boxSpaceHeight(double h, BuildContext context){
    return SizedBox(
      height: StyleSize(context).heightPercent(h),
    );
  }


}