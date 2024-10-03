import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/constant/Constant.dart';
// IMPORT
import '../model/Article.dart';

class ArticleCardWidget extends StatefulWidget {
  const ArticleCardWidget({super.key, required this.articleIndex});

  final Article articleIndex;

  @override
  State<ArticleCardWidget> createState() => _ArticleCardWidgetState();
}

class _ArticleCardWidgetState extends State<ArticleCardWidget> {
  @override
  Widget build(BuildContext context) {
    // Initialize
    final article = widget.articleIndex;

    return Stack(
      children: [

        //IMAGE
        GestureDetector(
          onTap: () {
            setState(() {

            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Thêm góc bo cho Container
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                article.urlToImage ??
                    'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),

        // OVERLAY
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.5), // Độ trong suốt của màu đen
          ),
        ),

        // AUTHOR
        Positioned(
          top: 60,
          left: 20,
          child: Column(
            children: [
              Text(
                "by ${article.author ?? 'Unknown'}",
                style: TextStyle(
                  fontFamily: textFontContent,
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        //TITLE
        Positioned(
          top: 75,
          left: 20,
          child: Container(
            width: 270,
            child: Text(
              article.title,
              style: TextStyle(
                fontFamily: textFontContent,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),

        //CONTENT
        Positioned(
          bottom: 15,
          left: 20,
          child: Container(
            width: 280,
            child: Text(
              "'${article.content ?? 'No content'}'",
              style: TextStyle(
                fontFamily: textFontContent,
                fontWeight: FontWeight.w300,
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
