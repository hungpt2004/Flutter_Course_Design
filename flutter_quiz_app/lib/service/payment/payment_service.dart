
import 'package:dio/dio.dart';
import 'package:flutter_quiz_app/model/completed_quiz.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../constant/payment_key.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment(int price, String username, int role, CompletedQuiz complete, int userId) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        price,
        "vnd",
      );
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: username,
        ),
      );
      await _processPayment();
      if(role == 1) {
        await DBHelper.instance.createNewCompleteQuiz(complete, userId);
        print('DA THUC HIEN MO KHOA');
      } else if (role == 2) {

      }
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(
          amount,
        ),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }


  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
