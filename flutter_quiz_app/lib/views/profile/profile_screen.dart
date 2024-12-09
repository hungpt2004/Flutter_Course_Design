import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/button/button_field.dart';
import 'package:flutter_quiz_app/components/button/button_icon.dart';
import 'package:flutter_quiz_app/components/input_field/input_text_field.dart';
import 'package:flutter_quiz_app/service/shared_preferences/singleton_user_manage.dart';
import 'package:flutter_quiz_app/theme/responsive_size.dart';

import '../../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = UserManager().currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if(state is LoginSuccess) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const BoxHeight(h: 70),
                    Center(
                      child: Container(
                        width: StyleSize(context).widthPercent(180),
                        height: StyleSize(context).heightPercent(180),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: !user!.url!
                                  .toString()
                                  .startsWith('/data/')
                                  ? CachedNetworkImageProvider(
                                  user!.url!)
                                  : FileImage(File(user!.url!)),
                              fit: BoxFit.cover)
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ButtonField(text: 'Upload', function: (){})),
                        ),
                      ),
                    // InputTextField(controller: controller, textInputAction: textInputAction, hint: hint, paddingRate: paddingRate)
                  ],
                ),
              ),
            );
          }
          return Center(child: ButtonField(text: 'Need to Login/Register', function: (){}),);
        },
      ),
    );
  }
}
