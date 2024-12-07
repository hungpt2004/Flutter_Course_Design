import '../../model/user.dart';
import 'local_data_save.dart';

class UserManager {
  //_internal ten constructor trong dart
  //
  //Su dung trong cac singleton pattern => tao ra 1 class duy nhat
  //
  //_ => private constructor

  static final UserManager _instance = UserManager._internal();
  User? currentUser;

  factory UserManager() {
    return _instance;
  }

  //constructor
  UserManager._internal();

  Future<void> loadUser() async {
    currentUser = await LocalSaveData().getDataUserLocal();
  }
}
