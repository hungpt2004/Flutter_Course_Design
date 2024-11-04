import 'package:course_app_flutter/firebase_options.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/bottom_navbar_provider.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/provider/document_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/views/bottom_navbar/bottom_navbar.dart';
import 'package:course_app_flutter/views/details/course_detail.dart';
import 'package:course_app_flutter/views/form/auth_screen.dart';
import 'package:course_app_flutter/views/form/forgot_password_screen.dart';
import 'package:course_app_flutter/views/form/widget/form_pin.dart';
import 'package:course_app_flutter/views/home/home_screen.dart';
import 'package:course_app_flutter/views/start/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  //Khoi tao firebase thich hop voi nen tang mac dinh
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (context) => DocumentProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/start": (context) => const StartPage(),
          "/auth": (context) => const AuthenticationScreen(),
          "/home": (context) => const HomeScreen(),
          "/forgot": (context) => const ForgotPasswordScreen(),
          "/formOtp": (context) => FormPinWidget(emailUser: ModalRoute.of(context)!.settings.arguments as String),
          "/bottom": (context) => const BottomNavbarWidget(),
          "/detail": (context) => const CourseDetailScreen()
        },
        initialRoute: "/auth",
      ),
    );
  }
}
