import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_category/category_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_favorite/favorite_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_pin/pin_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_send_email/email_bloc.dart';
import 'package:flutter_quiz_app/service/shared_preferences/local_data_save.dart';
import 'package:flutter_quiz_app/service/shared_preferences/singleton_user_manage.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'components/routes/app_routes.dart';
import 'constant/payment_key.dart';

void main() async {
  await _setup();
  await UserManager().loadUser();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => EmailBloc()),
      BlocProvider(create: (context) => PinBloc()),
      BlocProvider(create: (context) => CategoryBloc()),
      BlocProvider(create: (context) => QuizBloc()),
      BlocProvider(create: (context) => QuestionBloc()),
      BlocProvider(create: (context) => OwnQuizBloc()),
      BlocProvider(create: (context) => FavoriteBloc())
    ], child: const MyApp())
  );
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }


  Future initializeDatabase() async {
    final db = await DBHelper.instance.database;
    debugPrint("Database đã khởi tạo thành công");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.getAppRoutes(context),
      initialRoute: '/login',
    );
  }
}
