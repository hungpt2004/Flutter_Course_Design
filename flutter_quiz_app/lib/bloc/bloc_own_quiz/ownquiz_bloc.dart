import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_own_quiz/ownquiz_bloc_state.dart';

import '../../sql/sql_helper.dart';

class OwnQuizBloc extends Bloc<OwnQuizEvent, OwnQuizState> {
  OwnQuizBloc() : super(Initial()) {
    on<OnPressedLoading>(_onLoadingQuizzes);
  }

  Future<void> _onLoadingQuizzes(
      OnPressedLoading event, Emitter<OwnQuizState> emit) async {
    try {
      final quizzes = await DBHelper.instance.getQuizByUserId(event.userId);
      print('TRONG OWN LIST BLOC : ${quizzes.length}');
      emit(OwnQuizLoadingSuccess(quizzes: quizzes));
    } catch (e) {
      emit(OwnQuizLoadingFailure(e.toString()));
    }
  }

  static Future<void> loadingOwnQuiz(BuildContext context, int userId) async {
    print("loadingOwnQuiz được gọi với userId: $userId");
    context.read<OwnQuizBloc>().add(OnPressedLoading(userId));
  }
}
