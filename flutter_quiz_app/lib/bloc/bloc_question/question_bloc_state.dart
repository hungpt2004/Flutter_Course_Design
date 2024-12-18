import '../../model/question.dart';

abstract class QuestionState {}

class QuestionMoveSuccess extends QuestionState {
  int currentPage;
  QuestionMoveSuccess(this.currentPage);
}

class QuestionAddSuccess extends QuestionState {
  String text;
  List<Map<String,dynamic>> questionList;
  QuestionAddSuccess(this.text, this.questionList);
}

class QuestionAddFailure extends QuestionState {
  String text;
  List<Map<String,dynamic>> questionList;
  QuestionAddFailure(this.text, this.questionList);
}

class Initial extends QuestionState {}