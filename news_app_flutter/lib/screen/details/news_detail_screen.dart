import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/favourite_provider.dart';
import '../../model/article.dart';
import '../../providers/theme_provider.dart';
import '../../theme/message_dialog.dart';
import '../../theme/style.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key, required this.articleIndex});

  final Article articleIndex;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  bool isShare = false;

  @override
  Widget build(BuildContext context) {
    final provider = FavouriteProvider.of(context);
    final themeProvider = ThemeProvider.of(context);
    final Article article = widget.articleIndex;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                // IMAGE
                SizedBox(
                  width: double.infinity,
                  height: 370,
                  child: Style.networkImage(article.urlToImage!)
                ),
              ],
            ),

            // CONTENT
            Positioned(
              top: 330, // Adjust height to overlap image
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: themeProvider.isDark ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Style.space(70, 0),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: _description(
                                    article.content ?? 'Content', themeProvider)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0, left: 30, right: 30, bottom: 30),
                        child: Row(
                          children: [
                            Expanded(
                                child: _description(
                                    article.description ?? 'Description',
                                    themeProvider)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CONTAINER OVERLAY
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5.0, sigmaY: 5.0), // Adjust blur
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]!
                            .withOpacity(0.5), // Adjust opacity
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: _publishDate(article.publishedAt)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(child: _title(article.title))
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                    child: _author(article.author ?? 'Author'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // BACK BUTTON
            Positioned(
              top: 30,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 10, bottom: 10, right: 5),
                    child: Center(
                        child: Icon(
                      Icons.arrow_back_ios,
                      color:
                          themeProvider.isDark ? Colors.white : Colors.black54,
                    )),
                  ),
                ),
              ),
            ),

            // LOVE BUTTON
            Positioned(
              top: 30,
              right: 20,
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: IconButton(
                      onPressed: () async {
                          article.isFavourite
                              ? provider.toggleRemoveFavourite(article)
                              : provider.toggleAddFavourite(article);
                          if (article.isFavourite) {
                            showMessageDialog(
                                context, "Add favourite success", true);
                          } else {
                            showMessageDialog(
                                context, "Remove favourite success", false);
                          }
                      },
                      icon: Icon(
                        Icons.bookmark_sharp,
                        color: article.isFavourite
                            ? Colors.yellow
                            : Colors.white60,
                        size: 30,
                      ))),
            ),

            //SHARE BUTTON
            Positioned(
              top: 30,
              right: 75,
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: IconButton(
                      onPressed: () {
                        showDialogShareLink(context, article.url, isShare);
                        setState(() {
                          isShare = !isShare;
                        });
                      },
                      icon: Icon(
                        Icons.share,
                        color: isShare ? Colors.yellow : Colors.white60,
                        size: 30,
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  //DESCRIPTION
  Widget _description(String content, ThemeProvider themeProvider) {
    return Style.styleContentText(content, 17, themeProvider);
  }

  //TITLE
  Widget _title(String title) {
    return Text(
      title, // Add content here
      maxLines: 2,
      style: const TextStyle(
          fontSize: 17,
          fontFamily: textFontContent,
          fontWeight: FontWeight.w700,
          color: Colors.black),
    );
  }

  //AUTHOR
  Widget _author(String author) {
    return Text(
      "Published by $author", // Add content here
      style: const TextStyle(
          fontSize: 14,
          fontFamily: textFontContent,
          fontWeight: FontWeight.w500,
          color: Colors.black),
    );
  }

  //PUBLISH DATE
  Widget _publishDate(
    String date,
  ) {
    return Text(
      formatDate(date), // Add content here
      style: const TextStyle(
          fontSize: 14,
          fontFamily: textFontContent,
          fontWeight: FontWeight.w500,
          color: Colors.black),
    );
  }
}
