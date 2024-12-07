import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_favorite/favorite_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_favorite/favorite_bloc_event.dart';
import 'package:flutter_quiz_app/bloc/bloc_favorite/favorite_bloc_state.dart';
import 'package:flutter_quiz_app/bloc/bloc_quiz/quiz_bloc.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/box/box_width.dart';
import 'package:flutter_quiz_app/components/button/button_field.dart';
import 'package:flutter_quiz_app/components/snackbar/scaffold_snackbar_msg.dart';
import 'package:flutter_quiz_app/constant/email_key.dart';
import 'package:flutter_quiz_app/constant/label_str.dart';
import 'package:flutter_quiz_app/model/favorite.dart';
import 'package:flutter_quiz_app/service/payment/payment_service.dart';
import 'package:flutter_quiz_app/sql/sql_helper.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/network_image.dart';
import 'package:flutter_quiz_app/theme/responsive_size.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../model/quiz.dart';
import '../../../../model/user.dart';
import '../../../../service/shared_preferences/local_data_save.dart';

class CardQuizWidget extends StatefulWidget {
  CardQuizWidget({super.key, this.subjectId});

  int? subjectId;

  @override
  State<CardQuizWidget> createState() => _CardQuizWidgetState();
}

class _CardQuizWidgetState extends State<CardQuizWidget> {
  final networkImage = NetworkImageWidget();
  final textStyle = TextStyleCustom();
  User? user;
  bool? isFavorite;

  _loadUserFromLocalStore() async {
    User? myUser = await LocalSaveData().getDataUserLocal();
    if (myUser != null) {
      setState(() {
        user = myUser;
      });
    }
  }

  @override
  void initState() {
    _loadUserFromLocalStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          return FutureBuilder(
            future: widget.subjectId != null
                ? DBHelper.instance.getQuizBySubjectId(widget.subjectId!)
                : DBHelper.instance.getAllQuiz(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: primaryColor,
                );
              } else if (!snapshot.hasData || snapshot.hasError) {
                return const Text('Error in card quiz');
              } else {
                final quizList = snapshot.data;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: CROSS_COUNT,
                      mainAxisExtent: HEIGHT,
                      crossAxisSpacing: CROSS_SPACING,
                      mainAxisSpacing: MAIN_SPACING
                  ),
                  itemCount: quizList!.length,
                  itemBuilder: (context, index) {
                    final quizIndex = quizList[index];
                    return GestureDetector(
                      //Xu ly khi user nhan vao card => detail
                      onTap: (){},
                      child: Card(
                        elevation: 3,
                        color: fullColor,
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                height: StyleSize(context).heightPercent(100),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image: !quizIndex['url']
                                            .toString()
                                            .startsWith('/data/')
                                            ? CachedNetworkImageProvider(quizIndex['url'])
                                            : FileImage(File(quizIndex['url'])),
                                        fit: BoxFit.cover)),
                                child: Stack(
                                  children: [
                                    FutureBuilder(
                                      future: precacheImage(
                                          CachedNetworkImageProvider(quizIndex['url']),
                                          context),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return _loadingOverlay(); // Loading state
                                        } else if (snapshot.hasError) {
                                          return _errorOverlay(); // Error state
                                        } else {
                                          return const SizedBox.shrink(); // Success state, show nothing
                                        }
                                      },
                                    ),
                                    _overlay(),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (quizIndex['isFavorite'] == 0) {
                                            context.read<FavoriteBloc>().add(OnPressedAddFavorite(Favorite(userId: user!.id!, quizId: quizIndex['id'], createdAt: DateTime.now()), quizIndex['id'], user!.id!));
                                          } else if (quizIndex['isFavorite'] == 1) {
                                            context.read<FavoriteBloc>().add(OnPressedRemoveFavorite(quizIndex['id'], user!.id!));
                                          }
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.withOpacity(0.5)),
                                          child: Center(
                                            child: quizIndex['isFavorite'] == 0
                                                ? const Icon(Icons.favorite, color: Colors.white)
                                                : const Icon(Icons.favorite, color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.withOpacity(0.5)),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/svg/shopping.svg',
                                              width: 20,
                                              height: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            const BoxHeight(h: 10),
                            _title(quizIndex),
                            const BoxHeight(h: 8),
                            _information(quizIndex),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
        listener: (context, state) {
          if (state is FavoriteLoading) {
            ShowScaffoldMessenger.showScaffoldMessengerLoading(context, textStyle);
          } else if (state is FavoriteAddSuccess) {
            ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(context, state.text, textStyle);
          } else if (state is FavoriteAddFailure) {
            ShowScaffoldMessenger.showScaffoldMessengerUnsuccessfully(context, state.text, textStyle);
          } else if (state is FavoriteRemoveSuccess) {
            ShowScaffoldMessenger.showScaffoldMessengerSuccessfully(context, state.text, textStyle);
          }
        },
    );
  }

  Widget _information(Map<String, dynamic> quizIndex) {
    return FutureBuilder<User?>(
      future: DBHelper.instance.getUserById(quizIndex['user_id']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: primaryColor,
          );
        } else if (!snapshot.hasData || snapshot.hasError) {
          return const Text('Error in quiz card');
        } else {
          final user = snapshot.data;
          return _rowInformation(user!, quizIndex);
        }
      },
    );
  }

  Widget _overlay() {
    return Positioned.fill(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black12.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      ),
    );
  }

  Widget _loadingOverlay() {
    return const Center(
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }

  Widget _errorOverlay() {
    return const Center(
      child: Text(
        'Error loading image',
        style: TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }

  Widget _btn(Map<String, dynamic> quizIndex, User user) {
    return SizedBox(
        height: 50,
        child: Center(
          child: ButtonField(
              text: quizIndex['price'] == 0 ? 'Do Quiz' : 'Buy Quiz',
              function: () async {
                quizIndex['price'] == 0
                    ? await [
                        QuizBloc.enjoyQuiz(context, quizIndex['id']),
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushNamed(context, '/doQuiz');
                        })
                      ]
                    : await StripeService.instance
                        .makePayment(quizIndex['price'], user.username);
              }),
        ));
  }

  Widget _rowInformation(User user, Map<String, dynamic> quizIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_avatar(user), _price(quizIndex)],
          ),
          _btn(quizIndex, user)
        ],
      ),
    );
  }

  Widget _avatar(User user) {
    return Row(
      children: [
        SizedBox(
            width: 20,
            height: 20,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: networkImage.networkImage(user.url!),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.green,
                    ),
                    width: 4,
                    height: 4,
                  ),
                )
              ],
            )),
        const BoxWidth(w: 3),
        Text(
          user.name,
          style: textStyle.smallTextStyle(FontWeight.w500, Colors.black),
        )
      ],
    );
  }

  Widget _price(Map<String, dynamic> quizIndex) {
    return Text(
      quizIndex['price'] == 0 ? 'Free' : '${quizIndex['price']}\$',
      style: textStyle.superSmallTextStyle(FontWeight.bold, Colors.black),
    );
  }

  Widget _title(Map<String, dynamic> quizIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
            quizIndex['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textStyle.contentTextStyle(FontWeight.w600, Colors.black),
          ))
        ],
      ),
    );
  }


}
