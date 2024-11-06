import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/model/article.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/screen/details/news_detail_screen.dart';
import 'package:news_app_flutter/theme/style.dart';
import '../../providers/history_provider.dart';
import '../../theme/message_dialog.dart';

class ArticleListCategory extends StatelessWidget {
  final Future<List<Article>> articles;

  const ArticleListCategory({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {

    final historyProvider = HistoryProvider.of(context);
    final themeProvider = ThemeProvider.of(context);

    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Style.snapshotLoading(themeProvider);
        } else if (snapshot.hasError) {
          return Style.snapshotError(themeProvider);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Style.snapshotDataNull(themeProvider);
        }

        final articlesData = snapshot.data ?? [];
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: articlesData.length,
            itemBuilder: (context, index) {
              final article = articlesData[index];
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    //IMAGE
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              50), // Thêm góc bo cho Container
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Style.networkImage(article.urlToImage!)),
                      ),
                    ),

                    //OVERLAY
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            historyProvider.toggleHistoryNews(article);
                            Style.navigatorPush(
                                context,
                                NewsDetails(
                                  articleIndex: articlesData[index],
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(
                                  0.3), // Semi-transparent black overlay
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                      width: double.infinity * 0.2,
                                      height: 50,
                                      child: Style.styleTitleOnCard(
                                          article.title, 17)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          article.author ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: textFontContent,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Style.styleContentOnCard(
                                          formatDate(article.publishedAt), 10)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
