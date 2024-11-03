import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/content.dart';

class CardDocument extends StatefulWidget {
  const CardDocument({super.key, required this.contents});

  final List<Content> contents;

  @override
  State<CardDocument> createState() => _CardDocumentState();
}

class _CardDocumentState extends State<CardDocument> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.contents.length,
        itemBuilder: (context, index) {
          final contentIndex = widget.contents[index];
          return CardContent(content: contentIndex,);
        }
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
      child: Card(
        elevation: 10,
        color: kCardTitleColor,
        child: ListTile(
          title: Text(content.title,style: TextStyleApp.textStyleForm(14, FontWeight.w500,kDefaultColor),),
          trailing: TextButton(onPressed: (){}, child: TextStyleApp.underlineText("Read more ", 14, FontWeight.w500, kDefaultColor)),
        )
      ),
    );
  }
}
