abstract class OwnQuizState {}

class OwnQuizLoadingSuccess extends OwnQuizState {
  List<Map<String,dynamic>> quizzes;
  OwnQuizLoadingSuccess({required this.quizzes});
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