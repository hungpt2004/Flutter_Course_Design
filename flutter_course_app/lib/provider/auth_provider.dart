import 'package:course_app_flutter/repository/auth_repository.dart';
import 'package:course_app_flutter/theme/style/style_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {

  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  late User? _currentUser;

  User? get user => _currentUser;

  Future<void> credentialLogin(String username, String password, BuildContext context) async {
    _currentUser = await authenticationRepository.userCredentialLogin(username, password, context);
    notifyListeners();
  }

  Future<void> credentialRegister(User newUser, BuildContext context) async {
    List<User> listUser = await authenticationRepository.getAllUsers();
    bool existed = listUser.any((user) => user.username == newUser.username || user.email == newUser.email);
    if(existed){
      ToastStyle.toastFail("User are already existed");
      return;
    } else {
      await authenticationRepository.userCredentialRegister(newUser);
      ToastStyle.toastSuccess("User register successfully");
    }
    notifyListeners();
  }

  Future<void> credentialLogout() async {
    await _currentUser == null;
    notifyListeners();
  }

  static AuthenticationProvider stateAuthenticationProvider(BuildContext context, {listen = true}){
    return Provider.of(context, listen: listen);
  }

}