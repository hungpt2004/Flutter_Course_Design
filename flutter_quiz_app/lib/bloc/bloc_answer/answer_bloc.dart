import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_answer/answer_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_answer/answer_bloc_state.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';

import '../../model/question.dart';

class AnswerBloc extends Bloc<AnswerEvent, AnswerState> {

  AnswerBloc() : super(Initial()){
    on<OnPressedSelectAnswer>(_onSelectAnswer);
    on<OnPressSubmitAnswer>(_onSubmitQuiz);
  }

  static int currentQuestionIndex = 0;
  static int score = 0;
  static Map<int, int> selectedAnswered = {}; // Lưu câu trả lời đã chọn
  static int amountCorrectAnswer = 0;

  //Chon cau tra loi
  void _onSelectAnswer(OnPressedSelectAnswer event, Emitter<AnswerState> emit) async {
    try {
      //Tinh diem dua tren cau tra loi
      print('Cau hoi hien tai: $currentQuestionIndex');
      print('Cau tra loi dung: ${event.question['correct_answer']}');
      score += calculateScore(event.selectAnswer, event.question['correct_answer']);
      currentQuestionIndex++;
      print('Cau hoi tiep theo: $currentQuestionIndex');

      selectedAnswered[event.questionId] = event.selectAnswer;
      print('Danh sách câu trả lời đã chọn: $selectedAnswered');
      print('Diem sau khi hoan thanh cau : $score}');

      //Kiem tra het cau hoi hay chua
      if(currentQuestionIndex >= event.totalQuestion){
        emit(AnsweredAllQuestion('All question answered. You can now submit your answers'));
      } else {
        emit(AnswerSelectedSuccess('Answer selected successfully',selectedAnswered,event.questionId));
      }
    } catch (e) {
      emit(AnswerSelectedFailure(e.toString()));
    }
  }

  void _onSubmitQuiz(OnPressSubmitAnswer event, Emitter<AnswerState> emit) async {
    try {
      await DBHelper.instance.updateCompleteQuiz(score, event.userId, event.quizId, DateTime.now());
      print('Update xong roi');
      await DBHelper.instance.updateUserTotalScore(event.totalScore!, event.userId);
      print('DA SUBMIT1');
      emit(AnswerSubmitSuccess('Submit success', score));
    } catch (e) {
      print(e.toString());
      emit(AnswerSubmitFailure(e.toString()));
    }
  }


  //Neu tra loi dung => + 20 diem
  int calculateScore(int selectedAnswer, int correctAnswer) {
    amountCorrectAnswer++;
    return selectedAnswer == correctAnswer ? 20 : 0;
  }

  static Future<void> selectAnswer(BuildContext context, int selectedAnswer, int questionId, int totalQuestion, Map<String,dynamic> question) async {
    print('Dang o day');
    context.read<AnswerBloc>().add(OnPressedSelectAnswer(questionId, selectedAnswer, totalQuestion, question));
  }

  static Future<void> submitAnswer(BuildContext context, int userId, int quizId, int score, int totalScore) async {
    context.read<AnswerBloc>().add(OnPressSubmitAnswer(userId,quizId,score, totalScore));
  }

}