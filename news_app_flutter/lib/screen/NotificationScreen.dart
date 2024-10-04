import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/constant/Constant.dart';
import 'package:news_app_flutter/service/NewsDataAPI.dart';

import '../model/Article.dart';
import '../widget/ArticleNotificationCard.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: articles,
        builder: (conext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                  "Have no data when fetching data in Notification Screen"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Have an error when fetching data in Notification Screen"),
            );
          }
          final List<Article> articleList = snapshot.data!;
          return Scaffold(
            body: Stack(
              children: [

                //HOT UPDATES NEWS NOTIFICATION
                ArticleNotificationCard(
                  articleList: articleList,
                ),

                //BACK BUTTON
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.pop(context),
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 12, top: 10, bottom: 10, right: 5),
                              child: Center(child: Icon(Icons.arrow_back_ios)),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              "Hot Updates",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: textFontContent,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: primaryColors),
                            ),
                          ),

                          // Same width as the back arrow padding
                          SizedBox(
                            width: 48,
                          ),
                        ],
                      ),
                    )),

              ],
            ),
          );
        });
  }
}
