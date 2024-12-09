import '../../model/user.dart';

abstract class AuthEvent {}

class LoginOnPressed extends AuthEvent {
  String username;
  String password;
  LoginOnPressed({required this.username, required this.password});
}

class LogoutOnPressed extends AuthEvent {}

class RegisterOnPressed extends AuthEvent {
  User user;
  RegisterOnPressed({required this.user});
}

class ChangePasswordOnPressed extends AuthEvent {
  String email;
  String newPassword;
  ChangePasswordOnPressed({required this.email, required this.newPassword});
}

class UpdateOnPressed extends AuthEvent {

}