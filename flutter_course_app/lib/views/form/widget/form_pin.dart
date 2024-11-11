import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../theme/data/space_style.dart';
import '../../../theme/data/style_button.dart';
import '../../../theme/data/style_text.dart';

class FormPinWidget extends StatefulWidget {
  const FormPinWidget({super.key, required this.emailUser});

  final String emailUser;

  @override
  State<FormPinWidget> createState() => _FormPinWidgetState();
}

class _FormPinWidgetState extends State<FormPinWidget> {
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String num1;
  late String num2;
  late String num3;
  late String num4;
  late String pin;

  @override
  void initState() {
    num1 = '';
    num2 = '';
    num3 = '';
    num4 = '';
    pin = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);
    final authProvider =
        AuthenticationProvider.stateAuthenticationProvider(context);

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
            SpaceStyle.boxSpaceHeight(20,context),
            TextStyleApp.normalText(
                "Verification code", 33, FontWeight.w700, kPrimaryColor),
            SpaceStyle.boxSpaceHeight(20,context),
            Row(children: [
              Expanded(
                child: TextStyleApp.normalText(
                    "We have sent the code verification to",
                    14,
                    FontWeight.w500,
                    Colors.black38),
              )
            ]),
            Row(
              children: [
                Expanded(
                  child: TextStyleApp.normalText("${widget.emailUser}", 14,
                      FontWeight.w500, kPrimaryColor),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: TextStyleApp.normalText("Change the email ?", 14,
                        FontWeight.w500, Colors.indigo),
                  ),
                )
              ],
            ),
            SpaceStyle.boxSpaceHeight(20,context),
            Form(
              key: _formKey,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    inputField(context, 1),
                    inputField(context, 2),
                    inputField(context, 3),
                    inputField(context, 4),
                  ],
                ),
                SpaceStyle.boxSpaceHeight(20,context),
                Row(
                  children: [
                    Expanded(
                        child: ButtonStyleApp.customerButton(() async {
                      if (_formKey.currentState!.validate()) {
                        await loadingProvider.loading();
                        await authProvider.getPinInput(num1, num2, num3, num4);
                        bool check = await authProvider.verifyPin(authProvider.pin, widget.emailUser);
                        if(check){
                          Future.delayed(const Duration(milliseconds: 800),(){
                            formChangePassword(context, passwordController, () async {
                              await authProvider.changePassword(widget.emailUser, passwordController.text);
                            }, loadingProvider);
                          });
                        }
                      }
                    }, loadingProvider, "Confirm", kPrimaryColor ,kDefaultColor))
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  // MODAL BOTTOM SHEET
  void formChangePassword(BuildContext context, TextEditingController passwordController, VoidCallback? function, LoadingProvider loadProvider) {
    showModalBottomSheet(
        backgroundColor: kPrimaryColor,
        elevation: 15,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        sheetAnimationStyle: AnimationStyle(
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.easeInOutSine,
            duration: const Duration(seconds: 1),
            reverseDuration: const Duration(seconds: 1)),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SpaceStyle.boxSpaceHeight(15,context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey.withOpacity(0.4)
                      ),
                    )
                  ],
                ),
                SpaceStyle.boxSpaceHeight(15,context),
                inputPassword(passwordController),
                SpaceStyle.boxSpaceHeight(20,context),
                ButtonStyleApp.customerButton(function, loadProvider, "Change Password", kDefaultColor, kPrimaryColor)
              ],
            ),
          );
        });
  }

  // FIELD PASSWORD
  Widget inputPassword(TextEditingController passwordController) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.length < 3) {
          return "Password can't be empty or less than 3 character!";
        } else {
          return null;
        }
      },
      controller: passwordController,
      style: TextStyleApp.textStyleForm(16, FontWeight.w500, kPrimaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: kDefaultColor,
        labelText: 'New Password',
        labelStyle:
        TextStyleApp.textStyleForm(16, FontWeight.w300, kPrimaryColor),
        hintText: 'Enter password ...',
        hintStyle:
        TextStyleApp.textStyleForm(16, FontWeight.w300, kPrimaryColor),
        errorMaxLines: 1,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.eye),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.indigoAccent, // Màu khi trường đang được chọn
            width: 2, // Có thể điều chỉnh độ dày
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.indigoAccent, // Màu khi trường được kích hoạt
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.yellow, // Màu cho trạng thái lỗi
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.yellow, // Màu khi trường lỗi và được chọn
            width: 2,
          ),
        ),
      ),
    );
  }

  // INPUT
  Widget inputField(BuildContext context, int index) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kPrimaryColor, // Màu khi trường đang được chọn
              width: 2, // Có thể điều chỉnh độ dày
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: kPrimaryColor, // Màu khi trường được kích hoạt
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
              color: Colors.redAccent, // Màu khi trường lỗi và được chọn
              width: 2,
            ),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
            setState(() {
              if (index == 1) {
                num1 = value;
              }
              if (index == 2) {
                num2 = value;
              }
              if (index == 3) {
                num3 = value;
              }
              if (index == 4) {
                num4 = value;
              }
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Empty!";
          } else {
            return null;
          }
        },
        style: TextStyleApp.textStyleForm(16, FontWeight.w700, kSecondColor),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
