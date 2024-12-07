import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/views/authentication/change_password/change_password_screen.dart';
import 'package:flutter_quiz_app/views/authentication/forgot_password/forgot_password_screen.dart';
import 'package:flutter_quiz_app/views/authentication/login/login_screen.dart';
import 'package:flutter_quiz_app/views/authentication/pin_code/pin_screen.dart';
import 'package:flutter_quiz_app/views/authentication/register/register_screen.dart';
import 'package:flutter_quiz_app/views/bottom/bottom_navbar_screen.dart';
import 'package:flutter_quiz_app/views/exam_quiz/add_quiz/add_quiz_form.dart';
import 'package:flutter_quiz_app/views/exam_quiz/do_quiz/do_quiz_screen.dart';
import 'package:flutter_quiz_app/views/home/home_screen.dart';

import 'animation_routes.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> getAppRoutes(BuildContext context) {
    return {
      '/login':(context) => const LoginScreen(),
      '/register':(context) => const RegisterScreen(),
      '/forgot':(context) => const ForgotPasswordScreen(),
      '/pin':(context) => FormPinWidget(emailUser: ModalRoute.of(context)!.settings.arguments as String),
      '/password':(context) => ChangePasswordScreen(emailUser: ModalRoute.of(context)!.settings.arguments as String),
      '/home': (context) => const HomeScreen(),
      '/addQuiz':(context) => const AddQuizForm(),
      '/doQuiz':(context) => const DoQuizScreen(),
      '/': (context) => const BottomNavbarScreen()
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case '/login':
        return Transitions.slideFromRightTransition(const LoginScreen());
      case '/register':
        return Transitions.slideFromRightTransition(const RegisterScreen());
      case '/addQuiz':
        return Transitions.scaleTransition(const AddQuizForm());
      case '/password':
        return Transitions.slideFromRightTransition(ChangePasswordScreen(emailUser: ModalRoute.of(context)!.settings.arguments as String),);
      case '/pin':
        return Transitions.slideFromRightTransition(FormPinWidget(emailUser: ModalRoute.of(context)!.settings.arguments as String));
      default:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
    }
  }
}