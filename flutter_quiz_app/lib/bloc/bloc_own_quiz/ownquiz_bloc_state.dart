import '../../model/quiz.dart';

abstract class OwnQuizState {}

class OwnQuizLoadingSuccess extends OwnQuizState {
  List<Map<String,dynamic>> quizzes;
  List<Map<String,dynamic>> completeQuiz;
  List<Quiz?> quiz;
  OwnQuizLoadingSuccess({required this.quizzes, required this.completeQuiz,required this.quiz});
}

class OwnQuizLoadingFavorite extends OwnQuizState {
  List<Map<String,dynamic>> favorites;
  List<Map<String,dynamic>> quizzes;
  OwnQuizLoadingFavorite({required this.favorites,required this.quizzes});
}


class OwnQuizLoading extends OwnQuizState {
  bool isLoading;
  OwnQuizLoading(this.isLoading);
}

class OwnQuizLoadingFailure extends OwnQuizState {
  String text;
  OwnQuizLoadingFailure(this.text);
}

class Initial extends OwnQuizState {}