import 'package:course_app_flutter/models/enrollment.dart';
import 'package:course_app_flutter/models/favorite.dart';
import 'package:course_app_flutter/repository/auth_repository.dart';
import 'package:course_app_flutter/theme/data/style_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AuthenticationProvider extends ChangeNotifier {

  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  User? _currentUser;
  String _pin = '';
  bool _isObsecure = false;
  bool _readOnly = false;
  String _buttonText = 'Enroll';


  User? get user => _currentUser;
  String get pin => _pin;
  bool get isObsecure => _isObsecure;
  bool get readOnly => _readOnly;
  String get buttonText => _buttonText;

  void setUser(User user){
    _currentUser = user;
    notifyListeners();
  }


  // LOGIN
  Future<void> credentialLogin(String username, String password) async {
    _currentUser = await authenticationRepository.userCredentialLogin(username, password);
    notifyListeners();
  }

  // REGISTER
  Future<void> credentialRegister(User newUser, BuildContext context) async {
    List<User> listUser = await authenticationRepository.getAllUsers();
    bool existed = listUser.any((user) => user.username == newUser.username || user.email == newUser.email);

    if (existed) {
      ToastStyle.toastFail("User already exists");
    } else {
      await authenticationRepository.userCredentialRegister(newUser);
      ToastStyle.toastSuccess("User registered successfully");
      notifyListeners();
    }
  }

  // LOGOUT
  Future<void> credentialLogout() async {
    _currentUser = null;
    notifyListeners();
  }

  // CHANGE PASSWORD
  Future<void> changePassword(String email, String newPassword) async {
    _currentUser = await authenticationRepository.userChangePassword(email, newPassword);
    notifyListeners();
  }

  // CHECK EMAIL EXISTED
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
  Future<void> seePassword() async {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  Future<void> changeInformation() async {
    _readOnly = !_readOnly;
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
  Future<void> checkStatusEnroll(String userID, String courseID) async {
    bool isEnrolled = await authenticationRepository.statusEnroll(userID, courseID);
    _buttonText = isEnrolled ? "Enroll" : "Leave";
    notifyListeners();
  }


  // ================================================= USER'S FAVORITE ==============================================

  // ADD FAVORITES COURSE
  Future<void> addFavoriteCourse(String userID, Favorite fav) async {
    await authenticationRepository.addFavorite(userID, fav);
    await getAllFavorite(userID);
    notifyListeners();
  }

  // REMOVE FAVORITE
  Future<void> removeFavoriteCourse(String userID, String courseID) async {
    await authenticationRepository.removeFavorite(userID, courseID);
    await getAllFavorite(userID);
    notifyListeners();
  }

  // ALL FAVORITE
  Future<void> getAllFavorite(String userID) async {
    user!.favoriteCourse = await authenticationRepository.getAllFavorites(userID);
    notifyListeners();
  }

  static AuthenticationProvider stateAuthenticationProvider(BuildContext context, {bool listen = true}) {
    return Provider.of<AuthenticationProvider>(context, listen: listen);
  }

}
