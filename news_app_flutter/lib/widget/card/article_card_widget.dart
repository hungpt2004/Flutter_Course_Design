import 'package:flutter/material.dart';
import 'package:news_app_flutter/screen/details/news_detail_screen.dart';
import '../../model/article.dart';
import '../../providers/history_provider.dart';
import '../../theme/style.dart';

class ArticleCardWidget extends StatefulWidget {
  const ArticleCardWidget({super.key, required this.articleIndex});

  final Article articleIndex;

  @override
  State<ArticleCardWidget> createState() => _ArticleCardWidgetState();
}

class _ArticleCardWidgetState extends State<ArticleCardWidget> {
  @override
  Widget build(BuildContext context) {
    //PROVIDER
    final historyProvider = HistoryProvider.of(context);

    // Initialize
    final article = widget.articleIndex;

    return RepaintBoundary(
      child: Stack(
        children: [
          //IMAGE
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  50), // Thêm góc bo cho Container
            ),

            //IMAGE
            child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Style.networkImage(article.urlToImage!)),
          ),

          // OVERLAY
          GestureDetector(
            onTap: () {
              historyProvider.toggleHistoryNews(article);
              Style.navigatorPush(
                context,
                NewsDetails(
                  articleIndex: article,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:
                    Colors.black.withOpacity(0.5),
              ),
            ),
          ),

          // AUTHOR
          Positioned(
            top: 75,
            left: 20,
            child: Column(
              children: [
                Style.styleContentOnCard(
                    "by ${article.author ?? 'Unknown'}", 12)
              ],
            ),
          ),

          //TITLE
          Positioned(
            top: 90,
            left: 20,
            child: SizedBox(
                width: 300, child: Style.styleTitleOnCard(article.title, 14)),
          ),

          //CONTENT
          Positioned(
            bottom: 15,
            left: 20,
            child: SizedBox(
                width: 280,
                child: Style.styleContentOnCard(
                    "'${article.content ?? 'No content'}'", 12)),
          ),
        ],
      ),
    );
  }
}


