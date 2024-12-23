import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class UserRepository {

  List<User> users = usersList;

  // S I G N -- I N
  Future<User?> signInWithUsernamePassword(String username, String password) async {
    User? currentUser;
    for(User u in users) {
      if(u.username == password) {
        currentUser = u;
        break;
      }
    }
    if(currentUser == null) {
      debugPrint("Username incorrect");
      return null;
    } else if (currentUser!.password != password) {
      debugPrint("Password incorrect");
      return null;
    }
    debugPrint("Login successfully");
    return currentUser;
  }

  // G E T -- U S E R -- ID
  User? getUserByUserID(int userID) {
    for(User u in users) {
      if(u.id == userID) {
        return u;
      }
    }
    return null;
  }

}