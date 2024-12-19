import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_category/category_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_category/category_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_category/category_bloc_state.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/box/box_width.dart';
import 'package:flutter_quiz_app/service/shared_preferences/local_data_save.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/network_image.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';
import 'package:flutter_quiz_app/views/home/widget/advertisement/banner_ads_widget.dart';
import 'package:flutter_quiz_app/views/home/widget/categories/categories_quiz_widget.dart';
import 'package:flutter_quiz_app/views/home/widget/quiz/card_quiz_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../../model/rank.dart';
import '../../model/user.dart';
import '../../theme/responsive_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Rank? rank;
  User? currentUser;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyleCustom();
    final networkImage = NetworkImageWidget();

    return Scaffold(
        backgroundColor: fullColor,
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is LoginSuccess || state is UpdateAvatarSuccess) {
              currentUser = state is LoginSuccess
                  ? state.user
                  : (state as UpdateAvatarSuccess).user;
              return _body(currentUser!, networkImage, textStyle);
            }
            else if (state is UpdateNameSuccess) {
              currentUser = state.user;
              return _body(currentUser!, networkImage, textStyle);
            }
            else if (state is UpdateDOBSuccess) {
              currentUser = state.user;
              return _body(currentUser!, networkImage, textStyle);
            }
            else if (state is ResetPasswordSuccess) {
              currentUser = state.user;
              return _body(currentUser!, networkImage, textStyle);
            }
            return const Center(child: Text('Need to Login/Register'),);
          },
        )
    );
  }

  Widget _body(User user,NetworkImageWidget networkImage, TextStyleCustom textStyle){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const BoxHeight(h: 55),
            _header(user, networkImage, textStyle),
            const BoxHeight(h: 20),
            const BannerAdsWidget(),
            const BoxHeight(h: 15),
            textStyle.titleRow(textStyle, 'Categories'),

            // C A T E G O R I E S - S U B J E C T
            const BoxHeight(h: 5),
            const CategoriesQuizWidget(),

            const BoxHeight(h: 20),
            textStyle.titleRow(textStyle, 'Quizz'),

            // Q U I Z
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if(state is CategoryStateSuccess) {
                  return CardQuizWidget(subjectId: state.subjectId,);
                }
                return CardQuizWidget();
              },
            )

          ],
        ),
      ),
    );
  }

  Widget _header(User user, NetworkImageWidget networkImage, TextStyleCustom textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                width: StyleSize(context).widthPercent(50),
                height: StyleSize(context).heightPercent(50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: !user.url!
                            .toString()
                            .startsWith('/data/')
                            ? CachedNetworkImageProvider(
                            user.url!)
                            : FileImage(File(user.url!)),
                        fit: BoxFit.cover)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${user.name}',
                  style: textStyle.contentTextStyle(
                      FontWeight.w500, Colors.black),
                ),
              ],
            ),
          ],
        ),
        Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: secondaryColor
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/diamond.svg',
                    width: 20,
                    height: 20,
                  ),
                  const BoxWidth(w: 10),
                  Text(
                    '${user.totalScore}',
                    style: textStyle.contentTextStyle(
                        FontWeight.w400, Colors.black),
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Widget _bodyHeader(){
    return Column();
  }

}
