import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';

class ButtonCategory extends StatefulWidget {
  const ButtonCategory({super.key, required this.onSelected});

  final Function(String) onSelected;

  @override
  State<ButtonCategory> createState() => _ButtonCategoryState();
}

class _ButtonCategoryState extends State<ButtonCategory> {
  //List category
  final List<String> category = [
    "Health",
    "Technology",
    "Business",
    "Science",
    "Sports",
    "General",
    "Entertainment",
  ];

  String selectType = "";

  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          final type = category[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //BUTTON CHOOSE TYPE
                TextButton(
                    style: ButtonStyle(
                      elevation: const WidgetStatePropertyAll(4),
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.only(
                                right: 2, left: 2, top: 2, bottom: 2)),
                        backgroundColor: WidgetStatePropertyAll(
                            selectType == type
                                ? primaryColors
                                : Colors.transparent),
                        shape:
                            WidgetStatePropertyAll<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: selectType == type
                                            ? primaryColors
                                            : themeProvider.isDark ? Colors.white : Colors.black54,
                                        width: 1)))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        type,
                        style: TextStyle(
                            fontSize: 14,
                            color: selectType == type
                                ? Colors.white
                                : themeProvider.isDark ? Colors.white : Colors.black54,
                            fontFamily: textFontContent,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectType = type;
                      });
                      widget.onSelected(type);
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
