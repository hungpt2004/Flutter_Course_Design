import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_travel_booking/model/user.dart';
import 'package:flutter_travel_booking/repository/user_repository.dart';

class UserProvider extends StateNotifier<User?> {
  UserProvider() : super(null);
  User? _currentUser;
  List<User> users = usersList;

  User? get currentUser => _currentUser;

  final UserRepository userRepository = UserRepository();

  Future<void> signInWithUsernamePassword(String username, String password) async {
    _currentUser = await userRepository.signInWithUsernamePassword(username, password);
  }



}

//Khai bao river_pod
final userProvider = StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
