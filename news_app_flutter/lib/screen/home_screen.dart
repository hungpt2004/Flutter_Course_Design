import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/screen/notification_screen.dart';
import 'package:news_app_flutter/service/news_data_api.dart';
import 'package:news_app_flutter/widget/article_category_card_widget.dart';
import 'package:news_app_flutter/widget/button_category_widget.dart';
import 'package:news_app_flutter/widget/carousel_slide_widget.dart';
import 'package:news_app_flutter/widget/slide_page_route_widget.dart';
import '../constant/constant.dart';
import '../model/article.dart';
import '../widget/article_notification_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> articles;
  late List<Article> listArticle;
  bool isSelected1 = false;
  bool isSelected2 = true;
  bool isSelected3 = true;

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews();
    articles.then(
      (article) => setState(() {
        listArticle = article;
      }),
    );
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
        body: Stack(
          children: [
            Column(
              children: [

                SizedBox(height: 20,),

                //SEARCH & NOTIFICATION
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Dogecoin to the Moon...',
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
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
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
                ),

                const SizedBox(height: 10),

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
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              SlidePageRoute(
                                  page: ArticleNotificationCard(
                                      articleList: listArticle),
                                  beginOffset: Offset(1, 0),
                                  endOffset: Offset.zero,
                                  duration: Duration(milliseconds: 1000)));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "See All",
                              style: TextStyle(
                                color: secondaryColors,
                                fontFamily: textFontContent,
                                fontSize: 14,
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

                //SLIDE
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CouselSlideWidget(),
                ),

                //BUTTON CATEGORY
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: ButtonCategory(onSelected: fetchDataByCategory),
                ),

                //ARTICLE CATEGORY
                Expanded(
                  // Use Expanded to take up the remaining space
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ArticleListCategory(
                        articles: articles), // Use the ArticleList widget
                  ),
                ),

              ],
            ),

            //BOTTOM NAVBAR
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelected1 = !isSelected1;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.home,
                                    color: isSelected1
                                        ? Colors.grey
                                        : primaryColors,
                                  ),
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: textFontContent,
                                      fontWeight: FontWeight.w300,
                                      color: isSelected1 ? Colors.grey : primaryColors
                                  ),
                                )
                              ],
                            )),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSelected2 = !isSelected2;
                                  });
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color:
                                      isSelected2 ? Colors.grey : primaryColors,
                                ),
                              ),
                              Text(
                                "Favourite",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: textFontContent,
                                    fontWeight: FontWeight.w300,
                                    color: isSelected2 ? Colors.grey : primaryColors
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSelected3 = !isSelected3;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.person,
                                    color: isSelected3
                                        ? Colors.grey
                                        : primaryColors,
                                  ),
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: textFontContent,
                                      fontWeight: FontWeight.w300,
                                      color: isSelected3 ? Colors.grey : primaryColors
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
