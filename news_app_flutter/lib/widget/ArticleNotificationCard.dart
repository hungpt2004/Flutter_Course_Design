import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/constant/Constant.dart';

import '../model/Article.dart';

class ArticleNotificationCard extends StatelessWidget {
  const ArticleNotificationCard({Key? key, required this.articleList}) : super(key: key);

  final List<Article> articleList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: articleList.map((article) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          article.urlToImage ??
                              'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _formatDate(article.publishedAt),
                      style: TextStyle(fontSize: 15, fontFamily: textFontContent),
                    ),
                    SizedBox(height: 5),
                    Text(
                      article.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: textFontContent),
                    ),
                    SizedBox(height: 5),
                    Text(
                      article.description ?? '',
                      style: TextStyle(fontSize: 15, fontFamily: textFontContent),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Published by  ${article.author ?? ''}',
                      style: TextStyle(fontSize: 15, fontFamily: textFontContent, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5),
                    Divider(color: Colors.grey),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('EEEE, dd MMMM yyyy').format(parsedDate);
  }
}