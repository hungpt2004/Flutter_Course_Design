import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/screen/NotificationScreen.dart';
import 'package:news_app_flutter/service/NewsDataAPI.dart';
import 'package:news_app_flutter/widget/ArticleCategoryCard.dart';
import 'package:news_app_flutter/widget/ButtonCategory.dart';
import 'package:news_app_flutter/widget/CarouseSlide.dart';
import 'package:news_app_flutter/widget/SlidePageRoute.dart';
import '../constant/Constant.dart';
import '../model/Article.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> articles;
  String selectedType = "Healthy";

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews();
  }

  void fetchDataByCategory(String category) {
    setState(() {
      articles = APIService().getCategoryNews(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //SEARCH & NOTIFICATION
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search news ...',
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search_outlined,
                              color: Colors.grey[300],
                              size: 30,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          gapPadding: 4.5,
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: primaryColors),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            SlidePageRoute(
                              page: const NotificationScreen(),
                              beginOffset: const Offset(1, 0),
                              endOffset: Offset.zero,
                              duration: const Duration(milliseconds: 5),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            //BUTTON LATEST
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Latest News",
                    style: TextStyle(
                      fontFamily: textFontTitle,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "See All",
                          style: TextStyle(
                            color: secondaryColors,
                            fontFamily: textFontContent,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: secondaryColors,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            //SLIDE
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: LatestNewsSlideWidget(),
            ),

            //BUTTON CATEGORY
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ButtonCategory(onSelected: fetchDataByCategory),
            ),

            //ARTICLE CATEGORY
            Expanded( // Use Expanded to take up the remaining space
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ArticleListCategory(articles: articles), // Use the ArticleList widget
              ),
            ),

          ],
        ),
      ),
    );
  }
}
