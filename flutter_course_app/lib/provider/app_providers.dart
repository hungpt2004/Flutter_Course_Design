import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/bottom_navbar_provider.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/provider/document_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'loading_provider.dart';

class AppProviders {
  static List<SingleChildWidget> getAppProviders() {
    return [
      ChangeNotifierProvider(create: (context) => LoadingProvider()),
      ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (context) => CourseProvider()),
      ChangeNotifierProvider(create: (context) => BottomNavbarProvider()),
      ChangeNotifierProvider(create: (context) => DocumentProvider()),
    ];
  }
}