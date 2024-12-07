import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_question/question_bloc_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  QuestionBloc() : super(Initial()) {
    on<OnPressedMoveQuestion>(_onChangePage);
  }

  void _onChangePage(OnPressedMoveQuestion event, Emitter<QuestionState> emit) async {
    emit(QuestionMoveSuccess(event.currentIndex));
  }

  static Future<void> changePage(BuildContext context, int index) async {
    context.read<QuestionBloc>().add(OnPressedMoveQuestion(index));
  }

}