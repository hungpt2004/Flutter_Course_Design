import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/model/article.dart';
import 'package:news_app_flutter/screen/details/news_detail_screen.dart';
import 'package:news_app_flutter/widget/slide_page_route_widget.dart';

import '../providers/history_provider.dart';
import 'message_dialog.dart';

class ArticleListCategory extends StatelessWidget {
  final Future<List<Article>> articles;

  const ArticleListCategory({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    final historyProvider = HistoryProvider.of(context);

    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('CATEGORY: ${snapshot.data!.length}');
        } else if (snapshot.hasError) {
          return const Center(
              child:
                  Text('Have an error when fetching data in Article Category'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Have no data in Article Category'));
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
                              10), // Thêm góc bo cho Container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        //IMAGE
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

                    //OVERLAY
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () {
                            historyProvider.toggleHistoryNews(article);
                             Navigator.push(
                                context,
                                SlidePageRoute(
                                    page: NewsDetails(
                                      articleIndex: articlesData[index],
                                    ),
                                    beginOffset: const Offset(0, 1),
                                    endOffset: Offset.zero,
                                    duration:
                                    const Duration(milliseconds: 1000)),);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
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
                                    child: Text(
                                      article.title ?? 'Title',
                                      style: const TextStyle(
                                          fontFamily: textFontTitle,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
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
                                      Text(
                                        formatDate(article.publishedAt),
                                        style: const TextStyle(
                                            fontFamily: textFontContent,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
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

