import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/Constant.dart';

class ButtonCategory extends StatefulWidget {
  // const ButtonCategory({super.key, required this.onSelected});
  const ButtonCategory({super.key});

  //Required get a function when HomeScreen call this Widget
  // final Function(String) onSelected;

  @override
  State<ButtonCategory> createState() => _ButtonCategoryState();
}

class _ButtonCategoryState extends State<ButtonCategory> {

  //List category
  final List<String> category = [
    "Healthy",
    "Technology",
    "Finance",
    "Arts",
    "Sport",
    "Travel",
    "Entertainment",
  ];


  String selectType = "";


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          final type = category[index];
          final isSelected = type == selectType;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5)),
                        backgroundColor: MaterialStateProperty.all(
                            primaryColors
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: primaryColors, width: 2)
                            )
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        type,
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectType = type;
                      });
                      // widget.onSelected(type);
                    }
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
