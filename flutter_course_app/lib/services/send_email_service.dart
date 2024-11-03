import 'dart:convert';
import 'package:course_app_flutter/constant/email_key.dart';
import 'package:course_app_flutter/repository/auth_repository.dart';
import 'package:course_app_flutter/services/password_service.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../theme/data/style_toast.dart';

class SendEmailService {

  final PasswordService passwordService = PasswordService();
  final AuthenticationRepository authenticationRepository = AuthenticationRepository();

  final String _userID = user_id;
  final String _templateID = template_id;
  final String _serviceID = service_id;

  Future<void> sendEmail(String toEmail) async {

    List<User> listUser = await authenticationRepository.getAllUsers();

    bool existed = listUser.any((user) => user.email == toEmail);

    if (existed) {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      String password = passwordService.generateRandomPin();

      bool isCreatedNewPin = await authenticationRepository.createPinCodeFirebase(password, toEmail);

      if(!isCreatedNewPin){
        return;
      }

      try {
        final response = await http.post(url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'service_id': _serviceID,
              'template_id': _templateID,
              'user_id': _userID,
              'template_params': {
                'to_email': toEmail,
                'company_name': 'HPLearn Software Auto',
                'from_name': 'HPLearn Software Auto',
                'to_name': toEmail,
                'pin_code': password
              }
            }));
        if(response.statusCode == 200){
          ToastStyle.toastSuccess("Email are sent ! Check your email");
        } else {
          ToastStyle.toastFail("Email send failed");
          return;
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      ToastStyle.toastFail("User email is not existed");
      return;
    }
  }
}