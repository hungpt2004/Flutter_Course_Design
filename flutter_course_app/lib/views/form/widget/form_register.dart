import 'package:course_app_flutter/models/user.dart';
import 'package:course_app_flutter/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../../constant/color.dart';
import '../../../constant/reg_exp.dart';
import '../../../provider/loading_provider.dart';
import '../../../theme/data/space_style.dart';
import '../../../theme/data/style_text.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({super.key});

  @override
  State<FormRegisterWidget> createState() => _FormRegiterWidgetState();
}

class _FormRegiterWidgetState extends State<FormRegisterWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void refresh(){
    _usernameController.clear();
    _passwordController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final loadProvider = LoadingProvider.stateLoadingProvider(context);
    final authProvider = AuthenticationProvider.stateAuthenticationProvider(context);

    return Scaffold(
        backgroundColor: kDefaultColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SpaceStyle.boxSpaceHeight(20,context),
              TextStyleApp.normalText(
                  "Explore Now !", 33, FontWeight.w700, kPrimaryColor),
              SpaceStyle.boxSpaceHeight(10,context),
              Row(
                children: [
                  Expanded(child: googleLogin(() {})),
                ],
              ),
              SpaceStyle.boxSpaceHeight(10,context),
              Row(
                children: [Expanded(child: facebookLogin(() {}))],
              ),
              SpaceStyle.boxSpaceHeight(15,context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextStyleApp.normalText(
                          "or by email", 14, FontWeight.w500, kPrimaryColor),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      )),
                ],
              ),
              SpaceStyle.boxSpaceHeight(15,context),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Username can't be empty or less than 3 character!";
                          // } else if (!RegExp(regExpEmail).hasMatch(value)) {
                          //   return "Enter with correct format :<";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hoverColor: Colors.blue,
                            labelText: 'Username',
                            hintText: 'Enter username ...',
                            errorMaxLines: 1,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kSecondColor,
                                    width: 1,
                                    style: BorderStyle.solid))),
                      ),
                      SpaceStyle.boxSpaceHeight(10,context),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.length < 3) {
                            return "Password can't be empty or less than 3 character!";
                          } else {
                            return null;
                          }
                        },
                        obscureText: authProvider.isObsecure,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter password ...',
                            errorMaxLines: 1,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            suffixIcon: IconButton(
                                onPressed: ()  {
                                  authProvider.seePassword();
                                }, icon: Icon(authProvider.isObsecure ? CupertinoIcons.eye_slash : CupertinoIcons.eye)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kSecondColor,
                                    width: 1,
                                    style: BorderStyle.solid))),
                      ),
                      SpaceStyle.boxSpaceHeight(10,context),
                      TextFormField(
                        controller: _emailController,
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
                            labelText: 'Email Address',
                            hintText: 'Enter username ...',
                            errorMaxLines: 1,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: kSecondColor,
                                    width: 1,
                                    style: BorderStyle.solid))),
                      ),
                      SpaceStyle.boxSpaceHeight(10,context),
                      Row(
                        children: [Expanded(child: forgotPassword(() {}))],
                      ),
                      SpaceStyle.boxSpaceHeight(10,context),
                      loginButton(() async {
                        if(_formKey.currentState!.validate()){
                          await loadProvider.loading();
                          await authProvider.credentialRegister(User(userId: '', username: _usernameController.text, email: _emailController.text, password: _passwordController.text, createdAt: DateTime.now(), url: 'https://scontent.fdad1-4.fna.fbcdn.net/v/t39.30808-6/358129614_1333611757220509_5875824185090542378_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=a5f93a&_nc_ohc=qh7DK9fbl1UQ7kNvgFrtD9q&_nc_zt=23&_nc_ht=scontent.fdad1-4.fna&_nc_gid=AnbojAXZfO6qj4nTSdIWjRr&oh=00_AYANaOktRM2BwvX2rWMh9IRIMvE-cbhEv2QqsqA9mTxi9g&oe=67268354'), context);
                          refresh();
                        }
                      }, loadProvider,context),
                      backToLogin(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

Widget googleLogin(VoidCallback? function) {
  return SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      backgroundColor: Colors.white60.withOpacity(0.7),
      borderRadius: 15,
      onPressed: function);
}

Widget facebookLogin(VoidCallback? function) {
  return SocialLoginButton(
      buttonType: SocialLoginButtonType.facebook,
      borderRadius: 15,
      onPressed: function);
}

Widget forgotPassword(VoidCallback? function) {
  return TextButton(
    onPressed: function,
    child: TextStyleApp.normalText(
        "Forgot password?", 16, FontWeight.w500, kPrimaryColor),
  );
}

Widget loginButton(VoidCallback? function, LoadingProvider loadProvider, BuildContext context) {
  return ElevatedButton(
      onPressed:function,
      style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(4),
          backgroundColor: const WidgetStatePropertyAll(kPrimaryColor),
          shape: WidgetStatePropertyAll( loadProvider.isLoading ?  const CircleBorder() : RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          fixedSize: const WidgetStatePropertyAll(Size(396,60)),
          animationDuration: const Duration(milliseconds: 800)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: loadProvider.isLoading ? [
          const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: kDefaultColor,),)
        ] : [
          TextStyleApp.normalText(
              "Sign Up", 18, FontWeight.w700, kDefaultColor),
          SpaceStyle.boxSpaceWidth(10,context),
          const Icon(CupertinoIcons.arrow_right,color: kDefaultColor,size: 20,)
        ],
      ));
}

Widget backToLogin(BuildContext context){
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextStyleApp.normalText('You already have an account?', 14, FontWeight.w500, Colors.black),
        TextButton(onPressed: (){
          Navigator.pushNamed(context, "/formLogin");
        }, child: TextStyleApp.normalText("Sign In", 14, FontWeight.w500, kPrimaryColor))
      ],
    ),
  );
}