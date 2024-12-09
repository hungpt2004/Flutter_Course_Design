import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc_state.dart';

import '../../model/quiz.dart';
import '../../sql/sql_helper.dart';

class OwnQuizBloc extends Bloc<OwnQuizEvent, OwnQuizState> {
  OwnQuizBloc() : super(Initial()) {
    on<OnPressedLoading>(_onLoadingQuizzes);
    on<OnPressedLoadingFavorite>(_onLoadingFavorite);
  }

  //Load own quiz and process
  Future<void> _onLoadingQuizzes(OnPressedLoading event, Emitter<OwnQuizState> emit) async {
    try {
      final quizzes = await DBHelper.instance.getQuizByUserId(event.userId);
      final completeList = await DBHelper.instance.getAllCompleteQuizByUserId(event.userId);
      List<Quiz?> listQuiz = [];
      for(var c in completeList) {
        Quiz? quiz = await DBHelper.instance.getQuizById(c['quiz_id']);
        listQuiz.add(quiz);
      }
      emit(OwnQuizLoadingSuccess(quizzes: quizzes,completeQuiz: completeList,quiz: listQuiz));
    } catch (e) {
      emit(OwnQuizLoadingFailure(e.toString()));
    }
  }

  //Load favorite quiz
  Future<void> _onLoadingFavorite(OnPressedLoadingFavorite event, Emitter<OwnQuizState> emit) async {
    try {
      final favorites = await DBHelper.instance.getAllFavoriteByUserId(event.userId);
      final quizzes = await Future.wait<Map<String, dynamic>>(
          favorites.map((quiz) async {
            final quizData = await DBHelper.instance.getQuizById(quiz['quiz_id']);
            return quizData?.toMap() ?? {}; // Chuyển đổi Quiz thành Map
          })
      );
      print('TRONG FAVORITE LIST BLOC : ${favorites.length}');
      emit(OwnQuizLoadingFavorite(favorites: favorites, quizzes:quizzes));
    } catch (e) {
      emit(OwnQuizLoadingFailure(e.toString()));
    }
  }

  static Future<void> loadingQuiz(BuildContext context, int userId) async {
    print("loadingOwnQuiz được gọi với userId: $userId");
    context.read<OwnQuizBloc>().add(OnPressedLoading(userId));
  }

  static Future<void> loadingFavorite(BuildContext context, int userId) async {
    print("loadingOwnQuiz được gọi với userId: $userId");
    context.read<OwnQuizBloc>().add(OnPressedLoadingFavorite(userId));
  }

}
