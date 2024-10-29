import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/screen/auth/login_screen.dart';
import 'package:news_app_flutter/screen/home_screen.dart';
import 'package:news_app_flutter/theme/message_dialog.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../theme/style.dart';

class UserProvider extends ChangeNotifier {
  late User _currentUser;

  //GETTER
  User get currentUser => _currentUser;


  final List<User> _users = [
    User("1", "user01", "password01", "Nguyen Van A", "assets/images/user1.jpg",
        "0123456789", "user01@example.com", "United States", true),
    User("2", "user02", "password02", "Tran Thi B", "assets/images/user2.jpg",
        "0987654321", "user02@example.com", "London", false),
    User("3", "user03", "password03", "Le Van C", "assets/images/user3.jpg",
        "0123456781", "user03@example.com", "Viet Nam", true)
  ];

  List<User> get users => _users;

  //ADD USER
  void addUsers(BuildContext context, User user) {
    bool existedUser = _users.any((items) =>
        items.username == user.username || items.email == user.email);
    if (!existedUser) {
      _users.add(user);
      showMessageDialog(context, "Sign Up Successfully", true);
    } else if (existedUser) {
      showMessageDialog(context, "User already existed ! Login now", false);
    } else {
      showMessageDialog(context, "Sign Up Failed", false);
    }
    notifyListeners();
  }

  //LOGIN
  void login(BuildContext context, String username, String password) async {
    User? user = _users.firstWhere((items) => items.username == username && items.password == password);
    if (user != null) {
      _currentUser = user;
      showMessageDialog(context, "Login Successfully", true);
      await Future.delayed(const Duration(milliseconds: 1000));
      Style.navigatorPush(context, const HomeScreen());
    } else if (username != user.username && password != user.password){
      showMessageDialog(context, "Password or Username Incorrect", false);
    }
    notifyListeners();
  }

  //LOGOUT
  void logout(BuildContext context) async {
    _currentUser == "";
    await Future.delayed(const Duration(milliseconds: 1000));
    showMessageDialog(context, "Please wait a few seconds !", true);
    Style.navigatorPush(context, const LoginScreen());
  }

  //listen true => lang nghe su thay doi
  static UserProvider of(BuildContext context, {listen = true}) {
    return Provider.of(context, listen: listen);
  }

}
