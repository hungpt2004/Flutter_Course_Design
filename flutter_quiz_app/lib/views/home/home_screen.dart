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
import '../../service/shared_preferences/singleton_user_manage.dart';
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
  void initState() {
    super.initState();
  }

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
          } else if (state is UpdateNameSuccess) {
            currentUser = state.user;
            return _body(currentUser!, networkImage, textStyle);
          } else if (state is UpdateDOBSuccess) {
            currentUser = state.user;
            return _body(currentUser!, networkImage, textStyle);
          } else if (state is ResetPasswordSuccess) {
            currentUser = state.user;
            return _body(currentUser!, networkImage, textStyle);
          }
          return const Center(child: Text('Need to Login/Register'));
        },
      ),
    );
  }

  Widget _body(User user, NetworkImageWidget networkImage, TextStyleCustom textStyle) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: false,
          pinned: true, // Make the app bar stick at the top when scrolling
          title: _header(user, networkImage, textStyle),
          centerTitle: true,
          expandedHeight: 150,
          elevation: 10,
          backgroundColor: fullColor,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            expandedTitleScale: 1.5,
            collapseMode: CollapseMode.parallax,
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle
            ],
            background: Image.asset('assets/svg/background.jpg',fit: BoxFit.cover,),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
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
                    if (state is CategoryStateSuccess) {
                      return CardQuizWidget(subjectId: state.subjectId);
                    }
                    return CardQuizWidget();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(User user, NetworkImageWidget networkImage, TextStyleCustom textStyle) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
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
                    ? CachedNetworkImageProvider(user.url!)
                    : FileImage(File(user.url!)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, ${user.name}',
                style: textStyle.contentTextStyle(FontWeight.w500, Colors.black),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: secondaryColor,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/svg/diamond.svg',
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    '${user.totalScore}',
                    style: textStyle.contentTextStyle(FontWeight.w500, Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
