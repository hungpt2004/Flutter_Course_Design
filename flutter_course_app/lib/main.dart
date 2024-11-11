import 'package:course_app_flutter/firebase_options.dart';
import 'package:course_app_flutter/provider/app_providers.dart';
import 'package:course_app_flutter/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {

  //Khoi tao firebase thich hop voi nen tang mac dinh
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseMessagingService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.getAppProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.getAppRoutes(context),
        initialRoute: "/profile",
      ),
    );
  }
}
