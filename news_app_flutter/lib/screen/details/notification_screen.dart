import 'package:flutter/material.dart';
import 'package:news_app_flutter/service/news_data_api.dart';
import '../../model/article.dart';
import '../../providers/theme_provider.dart';
import '../../theme/style.dart';
import '../../widget/card/article_notification_card_widget.dart';

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
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
              return Style.snapshotLoading(themeProvider);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Style.snapshotError(themeProvider);
          } else if (snapshot.hasError) {
            return Style.snapshotDataNull(themeProvider);
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color:
                          !themeProvider.isDark ? Colors.white : Colors.black12,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Style.styleTitlePage("Hot Updates", 35, themeProvider)
                      ),
                    ),
                  ),
                  // Positioned Back Button
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color:
                            themeProvider.isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
