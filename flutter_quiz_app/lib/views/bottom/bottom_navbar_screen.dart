import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc.dart';
import 'package:flutter_quiz_app/bloc/bloc_auth/auth_bloc_state.dart';
import 'package:flutter_quiz_app/components/box/box_width.dart';
import 'package:flutter_quiz_app/theme/color.dart';
import 'package:flutter_quiz_app/theme/responsive_size.dart';
import 'package:flutter_quiz_app/theme/text_style.dart';
import 'package:flutter_quiz_app/views/exam_quiz/exam_quiz_screen.dart';
import 'package:flutter_quiz_app/views/favorite/favorite_screen.dart';
import 'package:flutter_quiz_app/views/home/home_screen.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavbarScreen extends StatefulWidget {
  const BottomNavbarScreen({super.key});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  int _currentIndex = 0;

  _toggleIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> pages = [
    const HomeScreen(),
    const ExamQuizScreen(),
    const Scaffold(
      body: Center(
        child: Text('Shopping Cart'),
      ),
    ),
    const FavoriteScreen(),
    const Scaffold(
      body: Center(
        child: Text('Account Setting'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex],
        floatingActionButton: _centerButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        bottomNavigationBar: _bottomAppBar());
  }

  //Button
  Widget _button(String urlToggle, String urlDefault, int index) {
    return Column(
      children: [
        MaterialButton(
            onPressed: () {
              _toggleIndex(index);
            },
            child: SvgPicture.asset(
                _currentIndex == index
                    ? "assets/svg/$urlToggle"
                    : "assets/svg/$urlDefault",
                width: 25,
                height: 25)
        ),
        Container(width: 10,height: 2,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: _currentIndex == index ? primaryColor : Colors.grey),)
      ],
    );
  }

  Widget _centerButton() {
    return FloatingActionButton(
      onPressed: () {
        _toggleIndex(2);
      },
      backgroundColor: primaryColor,
      elevation: 5,
      hoverElevation: 25,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), side: BorderSide.none),
      child: SvgPicture.asset(
        'assets/svg/shopping.svg',
        width: 30,
        height: 30,
      ),
    );
  }

  //Body
  Widget _bottomAppBar() {
    return BottomAppBar(
      height: StyleSize(context).heightPercent(80),
      color: fullColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: BorderSide.strokeAlignOutside,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _button('home_click.svg', 'home.svg', 0),
          _button('quiz_click.svg', 'quiz.svg', 1),
          const BoxWidth(w: 20),
          _button('hear_click.svg', 'hear.svg', 3),
          _button('account_click.svg', 'account.svg', 4),
        ],
      ),
    );
  }
}
