import 'package:course_app_flutter/constant/font.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastStyle {

  static toastSuccess(String msg){
    return Fluttertoast.showToast(
        msg: "✅ $msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static toastFail(String msg){
    return Fluttertoast.showToast(
        msg: "❌ $msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}