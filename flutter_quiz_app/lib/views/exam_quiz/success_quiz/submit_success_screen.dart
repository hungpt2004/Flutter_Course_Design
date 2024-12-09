import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/service/shared_preferences/singleton_user_manage.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';

import '../../../model/user.dart';

class SubmitSuccessScreen extends StatelessWidget {
  const SubmitSuccessScreen({super.key, required this.amountCorrectAnswer, required this.totalAnswer, required this.score, required this.totalTime});

  final int amountCorrectAnswer;
  final int totalAnswer;
  final int score;
  final double totalTime;

  @override
  Widget build(BuildContext context) {
    User? user = UserManager().currentUser;
    return Scaffold(
      body: Container(
        height: 500,
        child: FutureBuilder(
            future: DBHelper.instance.getAllCompleteQuizByUserId(3),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data!.length}'),
                    ),
                  );
                },
              );
            },
        ),
      ),
    );
  }
}
