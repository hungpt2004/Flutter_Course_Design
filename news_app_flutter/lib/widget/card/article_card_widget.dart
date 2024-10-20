import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/screen/details/news_detail_screen.dart';
import 'package:news_app_flutter/widget/route/slide_page_route_widget.dart';
// IMPORT
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
          _image(article),

          // OVERLAY
          GestureDetector(
            onTap: () {
              setState(() {
                historyProvider.toggleHistoryNews(article);
                Style.navigatorPush(
                  context,
                  NewsDetails(
                    articleIndex: article,
                  ),
                );
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    Colors.black.withOpacity(0.5), // Độ trong suốt của màu đen
              ),
            ),
          ),

          // AUTHOR
          Positioned(
            top: 75,
            left: 20,
            child: Column(
              children: [
                Style.styleContentOnCard("by ${article.author ?? 'Unknown'}", 12)
              ],
            ),
          ),

          //TITLE
          Positioned(
            top: 90,
            left: 20,
            child: SizedBox(
              width: 300,
              child: Style.styleTitleOnCard(article.title, 14)
            ),
          ),

          //CONTENT
          Positioned(
            bottom: 15,
            left: 20,
            child: SizedBox(
              width: 280,
              child: Style.styleContentOnCard("'${article.content ?? 'No content'}'", 12)
              ),
            ),
        ],
      ),
    );
  }
}

Widget _image(Article article) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(
      article.urlToImage!,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const SizedBox.shrink(); // Ẩn ảnh khi lỗi
      },
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    ),
  );
}
