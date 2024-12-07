import '../../model/quiz.dart';

abstract class QuizEvent {}

class OnPressedAddQuiz extends QuizEvent {
  Quiz quiz;
  int userId;
  OnPressedAddQuiz({required this.quiz, required this.userId});
}

class OnPressedRemoveQuiz extends QuizEvent {
  int id;
  OnPressedRemoveQuiz({required this.id});
}

class OnPressUpdateQuiz extends QuizEvent {
  Quiz quiz;
  OnPressUpdateQuiz({required this.quiz});
}

class OnPressEnjoyQuiz extends QuizEvent {
  int quizId;
  OnPressEnjoyQuiz({required this.quizId});
}

class OnPressChangedPage extends QuizEvent {
  final int currentPage;
  OnPressChangedPage(this.currentPage);
}