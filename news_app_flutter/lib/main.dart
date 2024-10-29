import 'package:flutter/material.dart';
import 'package:news_app_flutter/providers/favourite_provider.dart';
import 'package:news_app_flutter/providers/history_provider.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/providers/user_provider.dart';
import 'package:news_app_flutter/screen/start/get_started_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isDark = false;

  @override
  Widget build(BuildContext context) {

    bool isDark = false;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavouriteProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          final themeData = ThemeData(
            useMaterial3: true,
            brightness: provider.isDark ? Brightness.dark : Brightness.light,
          );

          return MaterialApp(
            theme: themeData,
            debugShowCheckedModeBanner: false,
            home: GetStartedScreen(isDark: isDark),
          );
        },
      ),
    );
  }
}


