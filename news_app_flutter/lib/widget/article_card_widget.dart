import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/screen/details/news_detail_screen.dart';
import 'package:news_app_flutter/widget/slide_page_route_widget.dart';
// IMPORT
import '../model/article.dart';
import '../providers/history_provider.dart';

class ArticleCardWidget extends StatefulWidget {
  const ArticleCardWidget({super.key, required this.articleIndex});

  final Article articleIndex;

  @override
  State<ArticleCardWidget> createState() => _ArticleCardWidgetState();
}

class _ArticleCardWidgetState extends State<ArticleCardWidget> {
  @override
  Widget build(BuildContext context) {

    final historyProvider = HistoryProvider.of(context);

    // Initialize
    final article = widget.articleIndex;
    //Provider
    return Stack(
      children: [

        //IMAGE
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            article.urlToImage ?? 'https://s.abcnews.com/images/US/abcnl__NEW_streamingnow_1664457649883_hpMain_16x9_608.jpg',
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return const SizedBox.shrink();  // Ẩn ảnh khi lỗi
            },
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // OVERLAY
        GestureDetector(
          onTap: () {
            setState(() {
              historyProvider.toggleHistoryNews(article);
              Navigator.push(
                  context,
                  SlidePageRoute(
                      page: NewsDetails(
                        articleIndex: article,
                      ),
                      beginOffset: const Offset(1, 0),
                      endOffset: Offset.zero,
                      duration: const Duration(milliseconds: 1000)));
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5), // Độ trong suốt của màu đen
            ),
          ),
        ),

        // AUTHOR
        Positioned(
          top: 75,
          left: 20,
          child: Column(
            children: [
              Text(
                "by ${article.author ?? 'Unknown'}",
                style: const TextStyle(
                  fontFamily: textFontContent,
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),

        //TITLE
        Positioned(
          top: 90,
          left: 20,
          child: Container(
            width: 300,
            child: Text(
              article.title ?? 'Title',
              style: const TextStyle(
                fontFamily: textFontContent,
                fontWeight: FontWeight.w600,
                fontSize: 14,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: textFontContent,
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        )

      ],
    );
  }
}
