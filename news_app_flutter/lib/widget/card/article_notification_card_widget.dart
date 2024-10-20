import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/theme/message_dialog.dart';
import '../../model/article.dart';
import '../../theme/style.dart';

class ArticleNotificationCard extends StatelessWidget {
  const ArticleNotificationCard({super.key, required this.articleList});

  final List<Article> articleList;

  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: articleList
                .map((article) => _buildArticleCard(article, context, themeProvider))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(Article article, BuildContext context, ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArticleImage(article),
          Style.space(10, 0),
          _buildPublishedDate(article,themeProvider),
          Style.space(5, 0),
          _buildArticleTitle(article,themeProvider),
          Style.space(5, 0),
          _buildArticleDescription(article,themeProvider),
          Style.space(5, 0),
          _buildArticleAuthor(article,themeProvider),
          Style.space(5, 0),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildArticleImage(Article article) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          article.urlToImage ??
              'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPublishedDate(Article article, ThemeProvider themeProvider) {
    return Style.styleContentText(formatDate(article.publishedAt), 15, themeProvider);
  }

  Widget _buildArticleTitle(Article article, ThemeProvider themeProvider) {
    return Style.styleContentText(article.title ?? 'Title', 18, themeProvider);
  }

  Widget _buildArticleDescription(Article article, ThemeProvider themeProvider) {
    return Style.styleContentText(article.description ?? '', 15, themeProvider);
  }

  Widget _buildArticleAuthor(Article article, ThemeProvider themeProvider) {
    return Style.styleContentText('Published by ${article.author ?? ''}', 15,themeProvider);
  }
}
