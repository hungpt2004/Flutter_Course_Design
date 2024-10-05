import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';

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



  String selectType = "Health";


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) {
          final type = category[index];
          final isSelected = type == selectType;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //BUTTON CHOOSE TYPE
                TextButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 5)),
                        backgroundColor: MaterialStateProperty.all(
                            selectType == type ? primaryColors : Colors.transparent
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: selectType == type ? primaryColors : Colors.black12,
                                  width: 1
                                )
                            )
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        type,
                        style: TextStyle(fontSize: 15, color:  selectType == type ? Colors.white : Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectType = type;
                      });
                      widget.onSelected(type);
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