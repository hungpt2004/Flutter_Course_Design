import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/theme/style.dart';

class LoginSocialNetwork extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String url;
  final String textControl;
  final Function function;

  const LoginSocialNetwork({
    super.key,
    required this.color,
    required this.textColor,
    required this.url,
    required this.textControl,
    required this.function,
  });

  @override
  _LoginSocialNetworkState createState() => _LoginSocialNetworkState();
}

class _LoginSocialNetworkState extends State<LoginSocialNetwork> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    return GestureDetector(
      onTap: () {
        widget.function(); // Gọi hàm khi widget được nhấn
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: widget.color),
          color: widget.color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset("assets/images/${widget.url}", height: 36),
            ),
            const SizedBox(width: 10),
            Style.styleContentText(widget.textControl, 18, themeProvider),
          ],
        ),
      ),
    );
  }
}
