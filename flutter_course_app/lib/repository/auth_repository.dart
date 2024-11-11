import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/models/enrollment.dart';
import 'package:course_app_flutter/models/favorite.dart';
import 'package:flutter/material.dart';
import '../models/pin.dart';
import '../models/user.dart';
import '../theme/data/style_toast.dart';

class AuthenticationRepository {

  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  //=============================================== AUTHENTICATION ==================================================

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
    final userCollection = firebaseFireStore.collection('users');
    List<User> listUser = await getAllUsers();

    //Create DocID follow User1, user2, user3, ...

    int maxID = findMaxID('user', listUser);

    String newUserId = "user${maxID + 1}";

    User newUser = User(
      userId: newUserId,
      username: user.username,
      email: user.email,
      password: user.password,
      createdAt: user.createdAt,
      url: user.url,
    );

    await userCollection.doc(newUser.userId).set(newUser.toFirebase());
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

    List<User> users = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Get enrollments and favorites for each user
      List<Enrollment> enrollments = await getAllEnrollments(doc.id);
      List<Favorite> favorites = await getAllFavorites(doc.id);

      users.add(User.fromFirebase(
        doc.data() as Map<String, dynamic>,
        doc.id,
        enrollments: enrollments,
        favorites: favorites,
      ));
    }
    return users;
  }

  // GET ALL ENROLLMENTS
  Future<List<Enrollment>> getAllEnrollments(String userID) async {
    QuerySnapshot querySnapshot = await firebaseFireStore.collection('users').doc(userID).collection('enrollments').get();
    return querySnapshot.docs.map((QueryDocumentSnapshot doc) => Enrollment.fromFirebase(doc.data() as Map<String, dynamic>,doc.id)).toList();
  }

  // GET ALL FAVORITES
  Future<List<Favorite>> getAllFavorites(String userID) async {
    QuerySnapshot querySnapshot = await firebaseFireStore.collection('users').doc(userID).collection('favorites').get();
    return querySnapshot.docs.map((QueryDocumentSnapshot doc) => Favorite.fromFirebase(doc.data() as Map<String, dynamic>,doc.id)).toList();
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
        ToastStyle.toastSuccess("Pin will expired in ${expiredTime.hour}h:${expiredTime.minute}m");
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
      ToastStyle.toastSuccess("Pin will expired in ${expiredTime.hour}h:${expiredTime.minute}m");
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



  //================================================== SAVE ENROLLMENT =============================================

  // ADD ENROLL
  Future<void> enrollCourse(String userID, Enrollment enrollment) async {
    final enrollmentCollection = firebaseFireStore.collection('users').doc(userID).collection('enrollments');
    List<Enrollment> enrollmentList = await getAllEnrollments(userID);
    bool existed = enrollmentList.any((e) => e.courseID == enrollment.courseID);
    if(existed) {
      await ToastStyle.toastFail("Already enroll this course");
      return;
    }

    int maxID = findMaxID('enrollment', enrollmentList);

    String newEnrollmentID = "enrollment${maxID + 1}";
    await enrollmentCollection.doc(newEnrollmentID).set(enrollment.toFirebase());
    ToastStyle.toastSuccess("Enroll this course successfully");
  }

  // REMOVE ENROLL
  Future<void> unEnrollCourse(String userID, String courseID) async {
    List<Enrollment> enrollmentList = await getAllEnrollments(userID);
    try {
      Enrollment? enrollment = enrollmentList.firstWhere((items) => items.courseID == courseID);

      await firebaseFireStore.collection('users').doc(userID).collection('enrollments').doc(enrollment.id).delete();
      await ToastStyle.toastSuccess("Un-enroll course successfully");
    } catch (e) {
      if (e is StateError) {
        await ToastStyle.toastFail("You have not enroll this course");
      } else {
        await ToastStyle.toastFail("Cannot Un-enroll course");
        throw Exception("Error when Un-enroll course $courseID: $e");
      }
    }
  }

  // CHECK STATUS ENROLL
  Future<bool> statusEnroll(String userID, courseID) async {
    List<Enrollment> enrollmentList = await getAllEnrollments(userID);
    return enrollmentList.any((items) => items.courseID == courseID);
  }


  //================================================== SAVE FAVORITE ===============================================

  // ADD FAVORITE
  Future<void> addFavorite(String userID, Favorite fav) async {
    final favoriteCollection = firebaseFireStore.collection('users').doc(userID).collection('favorites');
    List<Favorite> favoriteList = await getAllFavorites(userID);
    bool existed = favoriteList.any((e) => e.courseID == fav.courseID);
    if(existed) {
      await ToastStyle.toastFail("Already save this course");
      return;
    }

    int maxID = findMaxID('favorite', favoriteList);

    String newFavoriteID = "favorite${maxID + 1}";
    await favoriteCollection.doc(newFavoriteID).set(fav.toFirebase());
    await ToastStyle.toastSuccess("Save this course successfully");
  }

  //REMOVE FAVORITE
  Future<void> removeFavorite(String userID, String courseID) async {
    List<Favorite> favoriteList = await getAllFavorites(userID);

    try {
      // Tìm kiếm favorite dựa trên courseID
      Favorite favorite = favoriteList.firstWhere((e) => e.courseID == courseID);

      // Xóa mục yêu thích
      await firebaseFireStore.collection('users').doc(userID).collection('favorites').doc(favorite.id).delete();
      await ToastStyle.toastSuccess("Unlike course successfully");
    } catch (e) {
      // Nếu không tìm thấy mục yêu thích
      if (e is StateError) {
        await ToastStyle.toastFail("You have not like this course");
      } else {
        await ToastStyle.toastFail("Cannot remove favorite course");
        throw Exception("Error when remove favorite course $courseID: $e");
      }
    }
  }

  //ID TO INSERT
  int findMaxID(String prefixDocID, List<dynamic> list){
    int maxID = 0;
    for(var f in list) {
      int id = int.parse(f.id.replaceAll(prefixDocID, ''));
      if(id > maxID){
        maxID = id;
      }
    }
    return maxID;
  }

}