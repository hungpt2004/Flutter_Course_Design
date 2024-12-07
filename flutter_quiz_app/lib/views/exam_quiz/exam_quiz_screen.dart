import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_state.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/box/box_width.dart';
import 'package:flutter_quiz_app/components/button/button_field.dart';
import 'package:flutter_quiz_app/components/button/button_icon.dart';
import 'package:flutter_quiz_app/components/input_field/label_text.dart';
import 'package:flutter_quiz_app/components/snackbar/scaffold_snackbar_msg.dart';
import 'package:flutter_quiz_app/service/shared_preferences/local_data_save.dart';
import 'package:flutter_quiz_app/service/shared_preferences/singleton_user_manage.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/network_image.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/user.dart';

class ExamQuizScreen extends StatefulWidget {
  const ExamQuizScreen({super.key});

  @override
  State<ExamQuizScreen> createState() => _ExamQuizScreenState();
}

class _ExamQuizScreenState extends State<ExamQuizScreen> {
  final textStyle = TextStyleCustom();
  final networkImage = NetworkImageWidget();
  User? user = UserManager().currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Khi khoi tao ham build se chay ham loadOwnQuiz!
    OwnQuizBloc.loadingOwnQuiz(context, user!.id!);

    return Scaffold(
      backgroundColor: fullColor,
      body: _body(textStyle),
    );
  }

  Widget _body(TextStyleCustom textStyle) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const BoxHeight(h: 50),

            // A D D -- Q U I Z
            _addQuizForm(),

            // P R O G R E S S  -- Q U I Z
            textStyle.titleRow(textStyle, 'Processing'),

            // M Y -- Q U I Z -- C R U D
            const BoxHeight(h: 30),
            textStyle.titleRow(textStyle, 'My Quiz'),
            _myQuiz(networkImage)
          ],
        ),
      ),
    );
  }

  Widget _addQuizForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonIcon(text: 'Filter',icon: Icons.search,function: () {}),
        const BoxWidth(w: 10),
        ButtonIcon(
            text: 'Add Quiz',
            icon: Icons.add_circle_outline,
            function: () {
              Navigator.pushNamed(context, '/addQuiz');
            })
      ],
    );
  }

  Widget _myQuiz(NetworkImageWidget networkImage) {
    return BlocBuilder<OwnQuizBloc, OwnQuizState>(
      builder: (context, quizState) {
        //Neu trang thai success => phat ra 1 list quiz
        if (quizState is OwnQuizLoadingSuccess) {
          final quizList = quizState.quizzes;
          return BlocConsumer<QuizBloc, QuizState>(
              builder: (context, state) {
                return _listOwnQuiz(quizList);
              },
              listener: (context, state) {
                if (state is QuizDeleteSuccess) {
                  ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(
                      context, state.successMessage, textStyle);
                } else if (state is QuizAddSuccess) {
                  ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(
                      context, state.success, textStyle);
                } else if (state is QuizAddFailure) {
                  ShowScaffoldMessenger.showScaffoldMessengerUnsuccessfully(
                      context, state.error, textStyle);
                } else if (state is QuizDeleteFailure) {
                  ShowScaffoldMessenger.showScaffoldMessengerUnsuccessfully(
                      context, state.errorMessage, textStyle);
                }
              },
          );
        } else if (quizState is OwnQuizLoadingFailure) {
          return Text('Failed to load quizzes');
        } else {
          print(quizState);
          return CircularProgressIndicator(color: primaryColor);
        }
      },
    );
  }

  Widget _listOwnQuiz(List<Map<String, dynamic>> quizList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      itemCount: quizList.length,
      itemBuilder: (context, index) {
        return _cardQuiz(quizList[index], networkImage, textStyle);
      },
    );
  }

  Widget _cardQuiz(Map<String, dynamic> quiz, NetworkImageWidget networkImage,
      TextStyleCustom textStyle) {
    return Card(
      color: fullColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: SizedBox(
            width: 75,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: !quiz['url'].toString().startsWith('/data/')
                  ? networkImage.networkImage(quiz['url'])
                  : Image.file(
                      File(quiz['url']),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz['title'],
                style:
                    textStyle.contentTextStyle(FontWeight.w500, Colors.black),
              ),
              Text(
                textStyle
                    .formatDateFromText(DateTime.parse(quiz['created_at'])),
                style: textStyle.superSmallTextStyle(
                    FontWeight.w400, Colors.black),
              )
            ],
          ),
          trailing: SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/svg/pen.svg',
                      width: 20,
                      height: 20,
                    )),
                GestureDetector(
                    onTap: () async {
                      await QuizBloc.removeQuiz(context, quiz['id']);
                    },
                    child: SvgPicture.asset(
                      'assets/svg/trash.svg',
                      width: 20,
                      height: 20,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
