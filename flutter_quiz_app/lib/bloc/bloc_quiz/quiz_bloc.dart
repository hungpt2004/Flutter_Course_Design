import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_state.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';

import '../../model/quiz.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(Initial()){
    on<OnPressedAddQuiz>(_onAddQuiz);
    on<OnPressedRemoveQuiz>(_onRemoveQuiz);
    on<OnPressEnjoyQuiz>(_onJoinQuiz);
    on<OnPressChangedPage>(_onChangePage);
  }

  void _onAddQuiz(OnPressedAddQuiz event, Emitter<QuizState> emit) async {
    try {
      emit(QuizLoading(true));
      await DBHelper.instance.addNewQuiz(event.quiz, event.userId);
      emit(QuizAddSuccess('Add new quiz successfully'));
    } catch (e) {
      emit(QuizAddFailure(e.toString()));
      emit(QuizLoading(false));
    }
  }

  void _onRemoveQuiz(OnPressedRemoveQuiz event, Emitter<QuizState> emit) async {
    try {
      emit(QuizLoading(true));
      await DBHelper.instance.deleteQuizById(event.id);
      emit(QuizDeleteSuccess('Remove Quiz Success'));
    } catch (e) {
      emit(QuizDeleteFailure(e.toString()));
      emit(QuizLoading(false));
    }
  }

  void _onJoinQuiz(OnPressEnjoyQuiz event, Emitter<QuizState> emit) async {
     emit(EnjoyQuizSuccess(event.quizId));
  }

  void _onChangePage(OnPressChangedPage event, Emitter<QuizState> emit) async {
    print('Page trong BLOC : ${event.currentPage}');
    emit(PageChangedSuccess(currentPage: event.currentPage));
  }


  static Future<void> quiz(BuildContext context, Quiz quiz, int userId) async {
    context.read<QuizBloc>().add(OnPressedAddQuiz(quiz: quiz, userId: userId));
  }

  static Future<void> removeQuiz(BuildContext context, int quizId) async {
    context.read<QuizBloc>().add(OnPressedRemoveQuiz(id: quizId));
  }

  static Future<void> enjoyQuiz(BuildContext context, int quizId) async {
    context.read<QuizBloc>().add(OnPressEnjoyQuiz(quizId: quizId));
  }

  static Future<void> changePage(BuildContext context, int currentPage) async {
    context.read<QuizBloc>().add(OnPressChangedPage(currentPage));
  }

}