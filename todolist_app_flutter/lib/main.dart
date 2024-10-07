import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app_flutter/screens/home_screen.dart';

import 'models/task_data.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TaskData(),
      ),
    ],
    child: MyApp(), // Move child parameter here
  ),
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

