import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_answer/answer_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_answer/answer_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_state.dart';
import 'package:flutter_quiz_app/components/appbar/appbar_field.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/button/button_field.dart';
import 'package:flutter_quiz_app/components/snackbar/scaffold_snackbar_msg.dart';
import 'package:flutter_quiz_app/service/shared_preferences/singleton_user_manage.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/responsive_size.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';

import '../../../bloc/bloc_auth/auth_bloc.dart';
import '../../../model/user.dart';

class DoQuizScreen extends StatefulWidget {
  const DoQuizScreen({super.key, required this.quizId});

  final int quizId;

  @override
  State<DoQuizScreen> createState() => _DoQuizScreenState();
}

class _DoQuizScreenState extends State<DoQuizScreen> {
  final _pageController = PageController();
  final textStyle = TextStyleCustom();
  User? user = UserManager().currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom.appbarBackBtn(textStyle, context),
        body: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is EnjoyQuizSuccess) {
              return FutureBuilder(
                future: DBHelper.instance.getQuestionListByQuizId(state.quizId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Text('Error');
                  }
                  final questionList = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(
                        height: 500,
                        child: PageView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            onPageChanged: (index) {
                              Future.delayed(const Duration(milliseconds: 50),(){QuestionBloc.changePage(context, index);});
                            },
                            itemCount: questionList.length,
                            itemBuilder: (context, index) {
                              // options.add(questionList[index]['answer${index}']);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 20),
                                child: _bodyOfPageView(questionList[index], questionList.length),
                              );
                            }),
                      ),
                      _btn(questionList.length,)
                    ],
                  );
                },
              );
            }
            return const Center(child: Text('No question'));
          },
        ));
  }

  Widget _bodyOfPageView(Map<String, dynamic> question, int length) {
    return Column(
      children: [
        Card(
          elevation: 10,
          child: Container(
            width: StyleSize(context).screenWidth,
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          question['content'],
                          textAlign: TextAlign.center,
                          style: textStyle.questionTextStyle(
                              FontWeight.w700, Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _cardAnswer(
                        question['answer1'], 1, question['id'], length, question),
                    _cardAnswer(
                        question['answer2'], 2, question['id'], length, question),
                    _cardAnswer(
                        question['answer3'], 3, question['id'], length, question),
                    _cardAnswer(
                        question['answer4'], 4, question['id'], length, question),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardAnswer(String answer, int index, int questionId, int totalQuestion, Map<String,dynamic> question) {
    return GestureDetector(onTap: () async {
      await AnswerBloc.selectAnswer(context, index, questionId, totalQuestion, question);
      print('Da chon cau tra loi');
    }, child: BlocBuilder<AnswerBloc, AnswerState>(
      builder: (context, state) {
        bool isSelected = false;

        //Kiem tra dieu kien phu hop
        if (state is AnswerSelectedSuccess &&
            state.selectedAnswer.containsKey(questionId) &&
            state.selectedAnswer[questionId] == index) {
          isSelected = true;
        }

        print('State hiện tại: $state');
        print('isSelected = $isSelected');

        return BlocListener<AnswerBloc, AnswerState>(
          listener: (context, state) {
            if (state is AnswerSelectedSuccess && state.questionId == questionId) {
              print(questionId);
              print('state question = ${state.questionId}');
            } else if (state is AnsweredAllQuestion) {
              AnswerBloc.currentQuestionIndex = 0;
              AnswerBloc.score = 0;
              AnswerBloc.amountCorrectAnswer = 0;
            } else if (state is AnswerSubmitSuccess) {
              ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(context, state.text, textStyle);
            } else if (state is AnswerSubmitFailure) {
              ShowScaffoldMessenger.showScaffoldMessengerUnsuccessfully(context, state.text, textStyle);
            }
          },
          child: Card(
            elevation: 5,
            color: isSelected ? primaryColor : Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: SizedBox(
              width: StyleSize(context).widthPercent(300),
              height: StyleSize(context).heightPercent(50),
              child: Center(
                child: Text(
                  answer,
                  style:
                  textStyle.contentTextStyle(FontWeight.w600, isSelected ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  Widget _btn(int length) {
    return BlocBuilder<QuestionBloc, QuestionState>(
      builder: (context, state) {
        int currentPage = 0;
        if (state is QuestionMoveSuccess) {
          print('Page trong bloc : ${state.currentPage}');
          currentPage = state.currentPage;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              if (currentPage == length - 1) // Only show 'Submit' button on the last page
                ButtonField(
                  text: 'Submit',
                  function: () async {
                    print(user!.id!);
                    print( widget.quizId);
                    print(AnswerBloc.score);
                    await DBHelper.instance.updateCompleteQuiz(AnswerBloc.score, user!.id!, widget.quizId, DateTime.now());
                    await DBHelper.instance.updateUserTotalScore((user!.totalScore! + AnswerBloc.score), user!.id!);
                    await DBHelper.instance.updateRankByScore(AnswerBloc.score, user!.id!);
                    // go to success certificate

                    // await AnswerBloc.submitAnswer(context, user!.id!, widget.quizId, AnswerBloc.score,(user!.totalScore!+AnswerBloc.score));
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