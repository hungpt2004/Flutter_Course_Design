import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final Duration duration;
  final Offset beginOffset;
  final Offset endOffset;

  SlidePageRoute({required this.page, this.duration = const Duration(microseconds: 1000), required this.beginOffset, required this.endOffset})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      var tween = Tween(begin: beginOffset, end: endOffset)
          .chain(CurveTween(curve: Curves.ease)); // Áp dụng Curve

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: duration, // Áp dụng thời gian transition
  );
}