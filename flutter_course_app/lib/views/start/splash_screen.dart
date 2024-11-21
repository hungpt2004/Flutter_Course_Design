import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacementNamed(
            context,
            "/start",
          );
        }
      });

    // Chỉ bắt đầu hiệu ứng fade sau 3 giây
    Future.delayed(const Duration(seconds: 4), () {
      _controller.forward();
      setState(() {
        isExpanded = !isExpanded;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: StyleSize(context).screenHeight,
        width: StyleSize(context).screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            kPrimaryColor,homeBackgroundColor,
          ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(BorderSide.strokeAlignInside)
          )
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child:  Lottie.asset('assets/animation/animation.json'),
          ),
        ),
      ),
    );
  }
}
