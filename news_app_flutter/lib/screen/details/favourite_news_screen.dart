import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/favourite_provider.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/widget/article_category_card_widget.dart';
import 'package:news_app_flutter/widget/bottom_navbar_widget.dart';

import '../../model/article.dart';
import '../../widget/message_dialog.dart';
import '../../widget/slide_page_route_widget.dart';
import 'news_detail_screen.dart';

class FavouriteNewsScreen extends StatefulWidget {
  const FavouriteNewsScreen({super.key});


  @override
  State<FavouriteNewsScreen> createState() => _FavouriteNewsScreenState();
}

class _FavouriteNewsScreenState extends State<FavouriteNewsScreen> {
  @override
  Widget build(BuildContext context) {

    final provider = FavouriteProvider.of(context);
    final themeProvider = ThemeProvider.of(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background Container
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: !themeProvider.isDark ? Colors.white : Colors.black12,
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Text(
                    "Favourite News",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: textFontTitle,
                      fontSize: 40,
                      color: themeProvider.isDark ? Colors.white : primaryColors,
                      shadows: CupertinoContextMenu.kEndBoxShadow,
                    ),
                  ),
                ),
              ),
            ),
            // Positioned Back Button
            Positioned(
              top: 55,
              left: 5,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: themeProvider.isDark ? Colors.white : Colors.black,),
              ),
            ),
            // FutureBuilder for Articles
            Positioned.fill(
              top: 100, // Adjust the top position to avoid overlap with the title
              child: ListView.builder(
                itemCount: provider.articles.length,
                itemBuilder: (context, index) {
                    final article = provider.articles[index];
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                    Navigator.push(
                                        context,
                                        SlidePageRoute(
                                            page: NewsDetails(
                                              articleIndex: provider.articles[index],
                                            ),
                                            beginOffset: const Offset(0, 1),
                                            endOffset: Offset.zero,
                                            duration:
                                            const Duration(milliseconds: 1000)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent
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
                      ),
                    );
                },
              ),
            ),
            const BottomNavbarWidget(indexStaying: 1,)
          ],
        ),
      ),
    );
  }
}
