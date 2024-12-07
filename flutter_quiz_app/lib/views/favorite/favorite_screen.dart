import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/components/box/box_height.dart';
import 'package:flutter_quiz_app/components/box/box_width.dart';
import 'package:flutter_quiz_app/components/button/button_icon.dart';
import 'package:flutter_quiz_app/theme/color.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {


  showLeaderBoard() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Leaderboard of Ranks'),
          elevation: 15,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text('User 1'),
                Text('User 1'),
                Text('User 1'),
                Text('User 1'),
                Text('User 1'),
                Text('User 1')
              ],
            ),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fullColor,
      body: _body()
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

            //Button Leader Board
            const BoxHeight(h: 50),
            _buttonHeader()

          ],
        ),
      ),
    );
  }

  Widget _buttonHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ButtonIcon(text: 'Leaderboard', icon: Icons.leaderboard, function: (){showLeaderBoard();})
      ],
    );
  }

}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50); // Tạo một điểm cắt phía dưới
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
