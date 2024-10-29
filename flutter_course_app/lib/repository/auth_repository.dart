import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../theme/style/style_toast.dart';

class AuthenticationRepository {

  //Intialize databasee
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  // LOGIN
  Future<User?> userCredentialLogin(String username, String password, BuildContext context) async {
    List<User> listUser = await getAllUsers();
    User? currentUser;
    for(User user in listUser) {
      if(user.username == username){
        currentUser = user;
        break;
      }
    }
    if(currentUser == null) {
      ToastStyle.toastFail("Incorrect username");
      return null;
    } else if (currentUser.password != password) {
      ToastStyle.toastFail("Incorrect password");
      return null;
    }
    ToastStyle.toastSuccess("Login successfully!");
    return currentUser;
  }

  // REGISTER
  Future<void> userCredentialRegister(User user) async {
    List<User> listUser = await getAllUsers();

    //Create DocID follow User1, user2, user3, ...
    String newUserId = "user${listUser.length + 1}";

    User newUser = User(
      userId: newUserId,
      username: user.username,
      email: user.email,
      password: user.password,
      createdAt: user.createdAt,
      url: user.url,
    );

    await firebaseFireStore.collection('users').doc(newUser.userId).set(newUser.toFirebase());
  }


  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await firebaseFireStore.collection('users').get();

    // Test
    print(querySnapshot.docs.length);

    return querySnapshot.docs.map((QueryDocumentSnapshot doc) => User.fromFirebase(doc.data() as Map<String,dynamic> , doc.id)).toList();
  }


}