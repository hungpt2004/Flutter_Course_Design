abstract class OwnQuizEvent {}

class OnPressedLoading extends OwnQuizEvent {
  int userId;
  OnPressedLoading(this.userId);
}