import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/services/send_email_service.dart';
import 'package:flutter/material.dart';
import '../../constant/reg_exp.dart';
import '../../provider/loading_provider.dart';
import '../../theme/data/space_style.dart';
import '../../theme/data/style_button.dart';
import '../../theme/data/style_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final SendEmailService sendEmailService = SendEmailService();

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider =
        AuthenticationProvider.stateAuthenticationProvider(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);

    return Scaffold(
      backgroundColor: kDefaultColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SpaceStyle.boxSpaceHeight(50,context),
            Row(
              children: [ButtonStyleApp.backButton(context)],
            ),
            SpaceStyle.boxSpaceHeight(30,context),
            TextStyleApp.normalText(
                "Reset Your Password", 33, FontWeight.w700, kPrimaryColor),
            SpaceStyle.boxSpaceHeight(30,context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: TextStyleApp.textStyleForm(
                            16, FontWeight.w500, Colors.black),
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Email can't be empty or less than 3 character!";
                          } else if (!RegExp(regExpEmail).hasMatch(value)) {
                            return "Enter with correct format :<";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hoverColor: Colors.blue,
                          labelText: 'Email',
                          labelStyle: TextStyleApp.textStyleForm(
                              16, FontWeight.w300, kPrimaryColor),
                          hintText: 'Enter email ...',
                          hintStyle: TextStyleApp.textStyleForm(
                              16, FontWeight.w300, kPrimaryColor),
                          errorMaxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color:
                                  kPrimaryColor, // Màu khi trường đang được chọn
                              width: 2, // Có thể điều chỉnh độ dày
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color:
                                  kPrimaryColor, // Màu khi trường được kích hoạt
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.red, // Màu cho trạng thái lỗi
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors
                                  .redAccent, // Màu khi trường lỗi và được chọn
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SpaceStyle.boxSpaceHeight(30,context),
                      ButtonStyleApp.customerButton(() async {
                        if (_formKey.currentState!.validate()) {
                          await loadingProvider.loading();
                          await sendEmailService.sendEmail(
                              _emailController.text);
                        }
                      }, loadingProvider, "Send Email", kPrimaryColor, kDefaultColor),
                      SpaceStyle.boxSpaceHeight(30,context),
                      ButtonStyleApp.normalButton(() async {
                        if (_formKey.currentState!.validate()) {
                          bool check = await authProvider.checkEmailExist(_emailController.text);
                          if(check){
                            await Navigator.pushNamed(context, '/formOtp',
                                arguments: _emailController.text);
                          } else{
                            return;
                          }
                        }
                      },"Enter pin code", kPrimaryColor, kDefaultColor,kDefaultColor,30,15,5)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

