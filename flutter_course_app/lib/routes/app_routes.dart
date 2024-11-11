import 'package:course_app_flutter/views/profile/profile_screen.dart';
import 'package:course_app_flutter/views/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:course_app_flutter/views/bottom_navbar/bottom_navbar.dart';
import 'package:course_app_flutter/views/details/course_detail.dart';
import 'package:course_app_flutter/views/document/docs_details.dart';
import 'package:course_app_flutter/views/form/auth_screen.dart';
import 'package:course_app_flutter/views/form/forgot_password_screen.dart';
import 'package:course_app_flutter/views/form/widget/form_pin.dart';
import 'package:course_app_flutter/views/start/start_screen.dart';

import 'animation_routes.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> getAppRoutes(BuildContext context) {
    return {
      "/start": (context) => const StartPage(),
      "/auth": (context) => const AuthenticationScreen(),
      "/forgot": (context) => const ForgotPasswordScreen(),
      "/formOtp": (context) => FormPinWidget(emailUser: ModalRoute.of(context)!.settings.arguments as String),
      "/bottom": (context) => const BottomNavbarWidget(),
      "/detail": (context) => const CourseDetailScreen(),
      "/doc_detail": (context) => const DocumentDetailScreen(),
      "/splash": (context) => const SplashScreen(),
      "/profile":(context) => const UserProfileScreen()
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case '/auth':
        return Transitions.slideFromRightTransition(const AuthenticationScreen());
      case '/forgot':
        return Transitions.slideFromRightTransition(const ForgotPasswordScreen());
      case '/formOtp':
        return Transitions.fadeTransition(FormPinWidget(emailUser: ModalRoute.of(context)!.settings.arguments as String));
      case '/bottom':
        return Transitions.fadeTransition(const BottomNavbarWidget());
      case '/detail':
        return Transitions.scaleTransition(const BottomNavbarWidget());
      case '/doc_detail':
        return Transitions.scaleTransition(const BottomNavbarWidget());
      case '/splash':
        return Transitions.fadeTransition(const SplashScreen());
      default:
        return MaterialPageRoute(builder: (context) => const BottomNavbarWidget());
    }
  }
}
