import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/service/news_data_api.dart';

import '../../model/article.dart';
import '../../providers/theme_provider.dart';
import '../../widget/article_notification_card_widget.dart';

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
    final themeProvider = ThemeProvider.of(context);

    return FutureBuilder<List<Article>>(
        future: articles,
        builder: (conext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                  "Have no data when fetching data in Notification Screen"),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                  "Have an error when fetching data in Notification Screen"),
            );
          }
          final List<Article> articleList = snapshot.data!;
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [

                  //HOT UPDATES NEWS NOTIFICATION
                  Positioned(
                    top: 50,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ArticleNotificationCard(
                        articleList: articleList,
                      ),
                    ),
                  ),


                  //BACK BUTTON
                  Positioned(
                      top: 0,
                      left: 5,
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: themeProvider.isDark
                                ? Colors.black
                                : Colors.white),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => {
                                Navigator.pop(context),
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 10, bottom: 10, right: 5),
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_back_ios,
                                  color: themeProvider.isDark
                                      ? Colors.white
                                      : Colors.black,
                                )),
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
                                    color: themeProvider.isDark
                                        ? Colors.white
                                        : primaryColors),
                              ),
                            ),

                            // Same width as the back arrow padding
                            const SizedBox(
                              width: 48,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
