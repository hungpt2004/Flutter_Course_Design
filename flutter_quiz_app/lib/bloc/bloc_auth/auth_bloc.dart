import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/service/shared_preferences/local_data_save.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  AuthBloc() : super(Initial()) {
    on<LoginOnPressed>(_login);
    on<RegisterOnPressed>(_register);
    on<ChangePasswordOnPressed>(_changePassword);
  }

  void _login(LoginOnPressed event, Emitter<AuthState> emit) async {
    emit(LoginLoading(isLoading: true));
    try {
      User? user = await DBHelper.instance.getUserByUsername(event.username);
      if(user != null) {
        if(user.username == event.username && user.password == event.password) {
          await LocalSaveData().saveDataUserLocal(user);
          print('User trong BLOC ${user.name}');
          emit(LoginSuccess(user: user));
        } else {
          emit(LoginFailure(error: 'Wrong password or username'));
        }
      } else {
        emit(LoginFailure(error: 'No have user data'));
      }
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    } finally {
      if(state is! LoginSuccess){
        emit(LoginLoading(isLoading: false));
      }
    }
  }

  void _register(RegisterOnPressed event, Emitter<AuthState> emit) async {
    emit(RegisterLoading(isLoading: true));
    try {
      await DBHelper.instance.addNewUser(event.user);
      emit(RegisterLoading(isLoading: false));
      emit(RegisterSuccess(success: 'Register successfully'));
    } catch (e) {
      emit(RegisterLoading(isLoading: false));
      emit(RegisterFailure(error: e.toString()));
    }
  }

  void _changePassword(ChangePasswordOnPressed event, Emitter<AuthState> emit) async {
    try {
      emit(ResetPasswordLoading(isLoading: true)); // Bắt đầu loading
      await DBHelper.instance.updatePasswordUser(event.email, event.newPassword);

      emit(ResetPasswordSuccess(success: 'Change Password Successfully')); // Thành công
    } catch (e) {
      emit(ResetPasswordFailure(error: e.toString())); // Lỗi
    } finally {
      emit(ResetPasswordLoading(isLoading: false)); // Kết thúc loading
    }
  }



  static Future<void> login(BuildContext context, String username, String password) async {
    context.read<AuthBloc>().add(LoginOnPressed(username: username, password: password));
  }

  static Future<void> register(BuildContext context, User user) async {
    context.read<AuthBloc>().add(RegisterOnPressed(user: user));
  }

  static Future<void> changePassword(BuildContext context, String email, String newPassword) async {
    context.read<AuthBloc>().add(ChangePasswordOnPressed(email: email, newPassword: newPassword));
  }

}