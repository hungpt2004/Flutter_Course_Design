import 'package:course_app_flutter/repository/auth_repository.dart';
import 'package:course_app_flutter/theme/data/style_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  User? _currentUser;
  String _pin = '';

  User? get user => _currentUser;
  String get pin => _pin;

  Future<void> credentialLogin(String username, String password) async {
    _currentUser = await authenticationRepository.userCredentialLogin(username, password);
    notifyListeners(); // Chỉ gọi nếu _currentUser thực sự thay đổi
  }

  Future<void> credentialRegister(User newUser, BuildContext context) async {
    List<User> listUser = await authenticationRepository.getAllUsers();
    bool existed = listUser.any((user) => user.username == newUser.username || user.email == newUser.email);

    if (existed) {
      ToastStyle.toastFail("User already exists");
    } else {
      await authenticationRepository.userCredentialRegister(newUser);
      ToastStyle.toastSuccess("User registered successfully");
      notifyListeners(); // Gọi khi có đăng ký thành công
    }
  }

  Future<void> credentialLogout() async {
    _currentUser = null; // Đặt lại trạng thái người dùng
    notifyListeners(); // Chỉ gọi khi _currentUser thay đổi
  }

  Future<void> changePassword(String email, String newPassword) async {
    _currentUser = await authenticationRepository.userChangePassword(email, newPassword);
    notifyListeners(); // Gọi khi có thay đổi mật khẩu
  }

  Future<bool> checkEmailExist(String email) async {
    List<User> listUser = await authenticationRepository.getAllUsers();
    bool existed = listUser.any((user) => user.email == email);
    if (!existed) {
      ToastStyle.toastFail("Email does not exist");
    } else {
      debugPrint('Check email success');
    }
    return existed;
  }

  Future<bool> verifyPin(String pinCode, String email) async {
    return await authenticationRepository.verifyPin(pinCode, email);
  }

  Future<void> getPinInput(String num1, String num2, String num3, String num4) async {
    _pin = num1 + num2 + num3 + num4;
    notifyListeners(); // Gọi khi có thay đổi mã pin
  }

  static AuthenticationProvider stateAuthenticationProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<AuthenticationProvider>(context, listen: listen);
  }
}
