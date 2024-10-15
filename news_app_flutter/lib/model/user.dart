import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/widget/message_dialog.dart';

class User {
  String id;
  String username;
  String password;
  String fullName;
  String urlImage;
  String phoneNumber;
  String email;
  String country;
  bool gender;

  User(this.id, this.username, this.password, this.fullName, this.urlImage,
      this.phoneNumber, this.email,this.country, this.gender);
}

