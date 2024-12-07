import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc_event.dart';

abstract class QuestionEvent {}

class OnPressedMoveQuestion extends QuestionEvent {
  int currentIndex;
  OnPressedMoveQuestion(this.currentIndex);
}