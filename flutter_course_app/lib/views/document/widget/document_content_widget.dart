import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/document_provider.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/content.dart';

class CardDocument extends StatefulWidget {
  const CardDocument({super.key, required this.contents, required this.bigIndex});

  final List<Content> contents;
  final int bigIndex;

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
          return CardContent(content: contentIndex,index: widget.bigIndex,);
        }
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.content, required this.index});

  final Content content;
  final int index;

  @override
  Widget build(BuildContext context) {

    final docProvider = DocumentProvider.documentStateManagement(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
      child: Card(
        elevation: 10,
        color: index % 2 == 0 ? kCardTitleColor : kDefaultColor,
        child: ListTile(
          title: Text(content.title,style: TextStyleApp.textStyleForm(14, FontWeight.w500,index % 2 == 0 ? kDefaultColor : kCardTitleColor),),
          trailing: TextButton(onPressed: () async {
            await docProvider.toggleReadMore(content);
            Navigator.pushNamed(context, "/doc_detail");
          }, child: TextStyleApp.underlineText("Read more", 14, FontWeight.w500, index % 2 == 0 ? kDefaultColor : kCardTitleColor)),
        )
      ),
    );
  }
}
