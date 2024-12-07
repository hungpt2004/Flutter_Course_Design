abstract class QuestionState {}

class QuestionMoveSuccess extends QuestionState {
  int currentPage;
  QuestionMoveSuccess(this.currentPage);
}

class Initial extends QuestionState {}