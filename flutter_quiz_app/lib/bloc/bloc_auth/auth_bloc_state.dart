import '../../model/user.dart';

abstract class AuthState {}


//Before show form login
class Initial extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;
  LoginSuccess({required this.user});
}

class LoginFailure extends AuthState {
  final String error;
  LoginFailure({required this.error});
}

class LoginLoading extends AuthState {
  bool isLoading;
  LoginLoading({required this.isLoading});
}

class RegisterSuccess extends AuthState{
  final String success;
  RegisterSuccess({required this.success});
}

class RegisterFailure extends AuthState{
  final String error;
  RegisterFailure({required this.error});
}

class RegisterLoading extends AuthState {
  bool isLoading;
  RegisterLoading({required this.isLoading});
}

class ResetPasswordSuccess extends AuthState {
  final String success;
  ResetPasswordSuccess({required this.success});
}

class ResetPasswordFailure extends AuthState{
  final String error;
  ResetPasswordFailure({required this.error});
}

class ResetPasswordLoading extends AuthState {
  bool isLoading;
  ResetPasswordLoading({required this.isLoading});
}