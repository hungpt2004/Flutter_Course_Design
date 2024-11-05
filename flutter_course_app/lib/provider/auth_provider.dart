import 'package:course_app_flutter/models/enrollment.dart';
import 'package:course_app_flutter/models/favorite.dart';
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
  bool _isObsecure = false;

  User? get user => _currentUser;
  String get pin => _pin;
  bool get isObsecure => _isObsecure;

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
    _currentUser = null;
    notifyListeners();
  }

  Future<void> changePassword(String email, String newPassword) async {
    _currentUser = await authenticationRepository.userChangePassword(email, newPassword);
    notifyListeners();
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

  // VERIFY PIN
  Future<bool> verifyPin(String pinCode, String email) async {
    return await authenticationRepository.verifyPin(pinCode, email);
  }

  // GET PIN
  Future<void> getPinInput(String num1, String num2, String num3, String num4) async {
    _pin = num1 + num2 + num3 + num4;
    notifyListeners();
  }

  // OBSECURE TEXT
  void seePassword() async {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }


  // ================================================= USER'S COURSE ==============================================

  // ENROLL COURSE
  Future<void> joinCourse(String userID, Enrollment enrollment) async {
    await authenticationRepository.enrollCourse(userID, enrollment);
    await getAllEnrollment(userID);
    notifyListeners();
  }

  // UN-ENROLL COURSE
  Future<void> leaveCourse(String userID, String courseID) async {
    await authenticationRepository.unEnrollCourse(userID, courseID);
    await getAllEnrollment(userID);
    notifyListeners();
  }

  // GET ALL ENROLLMENTS
  Future<void> getAllEnrollment(String userID) async {
    user!.enrollCourse = await authenticationRepository.getAllEnrollments(userID);
    notifyListeners();
  }

  // CHECK STATUS ENROLL
  Future<bool> checkStatusEnroll(String userID, String courseID) async {
    return await authenticationRepository.statusEnroll(userID, courseID);
  }


  // ================================================= USER'S FAVORITE ==============================================

  // ADD FAVORITES COURSE
  Future<void> addFavoriteCourse(String userID, Favorite fav) async {
    await authenticationRepository.addFavorite(userID, fav);
    await getAllFavorite(userID);
    notifyListeners();
  }

  Future<void> removeFavoriteCourse(String userID, String courseID) async {
    await authenticationRepository.removeFavorite(userID, courseID);
    await getAllFavorite(userID);
    notifyListeners();
  }

  Future<void> getAllFavorite(String userID) async {
    user!.favoriteCourse = await authenticationRepository.getAllFavorites(userID);
    notifyListeners();
  }

  static AuthenticationProvider stateAuthenticationProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<AuthenticationProvider>(context, listen: listen);
  }

}
