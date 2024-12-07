import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_state.dart';
import 'package:flutter_quiz_app/components/appbar/appbar_field.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/button/button_field.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/responsive_size.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';

import '../../../bloc/bloc_auth/auth_bloc.dart';
import '../../../model/user.dart';

class DoQuizScreen extends StatefulWidget {
  const DoQuizScreen({super.key});

  @override
  State<DoQuizScreen> createState() => _DoQuizScreenState();
}

class _DoQuizScreenState extends State<DoQuizScreen> {
  final _pageController = PageController();
  final textStyle = TextStyleCustom();
  bool isChosen = false;
  int currentAnswer = 0;

  void toggleChoose(int index) {
    setState(() {
      isChosen = !isChosen;
      currentAnswer = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom.appbarBackBtn(textStyle, context),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is EnjoyQuizSuccess) {
            return FutureBuilder(
              future:
              DBHelper.instance.getQuestionListByQuizId(state.quizId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError || !snapshot.hasData) {
                  return const Text('Error');
                }
                final questionList = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            QuestionBloc.changePage(context, index);
                          },
                          itemCount: questionList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 20),
                              child: _bodyOfPageView(questionList[index], questionList.length),
                            );
                          }),),
                    _btn(questionList.length)
                  ],
                );
              },
            );
          }
          return Container(
            child: const Center(child: Text('No question')),
          );
        },
      )
    );
  }

  Widget _bodyOfPageView(Map<String, dynamic> question, int length) {
    return Column(
      children: [
        Card(
          elevation: 10,
          child: Container(
            width: StyleSize(context).screenWidth,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      question['content'],
                      style: textStyle.questionTextStyle(
                          FontWeight.w700, Colors.black),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _cardAnswer(question['answer1'],1),
                        _cardAnswer(question['answer2'],2),
                      ],
                    ),
                    const BoxHeight(h: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _cardAnswer(question['answer3'],3,),
                        _cardAnswer(question['answer4'],4),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardAnswer(String answer, int index) {
    return GestureDetector(
      onTap: () {
        toggleChoose(index);
      },
      child: Card(
        elevation: 5,
        color: currentAnswer == index ? primaryColor : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: 110,
          height: 35,
          child: Center(
            child: Text(
              answer,
              style: textStyle.contentTextStyle(FontWeight.w500, currentAnswer == index ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _btn(int length) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        int currentPage = 0;
        if(state is QuestionMoveSuccess) {
          print('Page trong bloc : ${state.currentPage}');
          currentPage = state.currentPage;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (currentPage > length )
                ButtonField(text: 'Submit', function: (){}),
              if (currentPage > 0)
                ButtonField(
                  text: 'Back',
                  function: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              if (currentPage < length - 1)
                ButtonField(
                  text: 'Next',
                  function: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
            ],
          );
        }
        return Container();
      },
    );
  }

}
