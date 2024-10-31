import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/services/send_email_service.dart';
import 'package:flutter/material.dart';

import '../models/pin.dart';
import '../models/user.dart';
import '../theme/style/style_toast.dart';

class AuthenticationRepository {

  //Intialize databasee
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  // LOGIN
  Future<User?> userCredentialLogin(String username, String password) async {
    List<User> listUser = await getAllUsers();
    User? currentUser;
    for(User user in listUser) {
      if(user.username == username){
        currentUser = user;
        break;
      }
    }
    if(currentUser == null) {
      ToastStyle.toastFail("Incorrect username!");
      return null;
    } else if (currentUser.password != password) {
      ToastStyle.toastFail("Incorrect password!");
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

  // UPDATE PASSWORD
  Future<User?> userChangePassword(String email, String newPassword) async {
    List<User> listUser = await getAllUsers();
    User? currentUser;
    for(User user in listUser){
      if(user.email == email){
        currentUser = user;
        break;
      }
    }
    if(currentUser == null){
      ToastStyle.toastFail("Email is not existed!");
      return null;
    }

    currentUser.password == newPassword;

    //Save updated to firebase database
    try {
      await firebaseFireStore.collection('users').doc(currentUser.userId).update({
        'password': newPassword,
      });
      ToastStyle.toastSuccess("Update success");
    } catch (e) {
      ToastStyle.toastFail("Update failed");
      return null;
    }
    return currentUser;
  }

  // GET ALL USER
  Future<List<User>> getAllUsers() async {
    QuerySnapshot querySnapshot = await firebaseFireStore.collection('users').get();
    return querySnapshot.docs.map((QueryDocumentSnapshot doc) => User.fromFirebase(doc.data() as Map<String,dynamic> , doc.id)).toList();
  }


  //==================================================== PIN ===========================================================

  // ADD PIN TO FIREBASE
  Future<bool> createPinCodeFirebase(String pinCode, String email) async {

    DocumentSnapshot doc = await firebaseFireStore.collection('pins').doc(email).get();

    if (doc.exists) {
      //Check date
      DateTime expireAt = DateTime.parse(doc['expire_at']);
      DateTime realTimeInput= DateTime.now();

      if(realTimeInput.isAfter(expireAt)){
        await firebaseFireStore.collection('pins').doc(email).delete();
        debugPrint('DELETED EXPIRED PIN');

        //create a new pin
        DateTime expiredTime = DateTime.now().add(const Duration(minutes: 5));
        String expireAt = expiredTime.toIso8601String();

        Pin newPin = Pin(pin: pinCode, expireAt: expireAt);

        await firebaseFireStore.collection('pins').doc(email).set(newPin.toFirebase());
        ToastStyle.toastSuccess("Pin will expired in ${expiredTime.hour}h:${expiredTime.minute}");
        debugPrint('RUN AFTER SAVE PIN SET PIN TO FIREBASE SUCCESS');
        return true;

      } else {
        ToastStyle.toastFail("Already request pin");
        return false;
      }
    } else {
      DateTime expiredTime = DateTime.now().add(const Duration(minutes: 5));
      String expireAt = expiredTime.toIso8601String();

      Pin newPin = Pin(pin: pinCode, expireAt: expireAt);

      await firebaseFireStore.collection('pins').doc(email).set(newPin.toFirebase());
      ToastStyle.toastSuccess("Pin will expired in ${expiredTime.hour}h:${expiredTime.minute}");
      debugPrint('RUN AFTER CREATE PIN THE FIRST TIME');
      return true;
    }
  }

  // VERIFY PIN
  Future<bool> verifyPin(String inputPin, String inputEmail) async {
    DocumentSnapshot doc = await firebaseFireStore.collection('pins').doc(inputEmail).get();
    DateTime realTimeInput= DateTime.now();
    DateTime startTime = DateTime.parse(doc['expire_at']).subtract(const Duration(minutes: 5));
    DateTime expireAt = DateTime.parse(doc['expire_at']);

    if(!doc.exists){
      await ToastStyle.toastFail("No pin request !");
      return false;
    }
    
    if(inputPin == doc['pin'] && (realTimeInput.isAfter(startTime) && realTimeInput.isBefore(expireAt))){
      ToastStyle.toastSuccess("Pin code is correct");
      return true;
    } else if (inputPin != doc['pin'] || realTimeInput.isAfter(expireAt)) {
      ToastStyle.toastFail("Pin code is error ! Request again");
      return false;
    }
    return false;
  }

  // GET ALL PIN
  Future<List<Pin>> getAllPins() async {
    QuerySnapshot querySnapshot = await firebaseFireStore.collection('pins').get();
    return querySnapshot.docs.map((QueryDocumentSnapshot doc) => Pin.fromFirebase(doc.data() as Map<String, dynamic>)).toList();
  }



}