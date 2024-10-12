import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/screen/details/favourite_news_screen.dart';
import 'package:news_app_flutter/screen/details/notification_screen.dart';
import 'package:news_app_flutter/screen/details/search_screen.dart';
import 'package:news_app_flutter/service/news_data_api.dart';
import 'package:news_app_flutter/widget/article_category_card_widget.dart';
import 'package:news_app_flutter/widget/bottom_navbar_widget.dart';
import 'package:news_app_flutter/widget/button_category_widget.dart';
import 'package:news_app_flutter/widget/carousel_slide_widget.dart';
import 'package:news_app_flutter/widget/slide_page_route_widget.dart';
import '../constant/constant.dart';
import '../model/article.dart';
import '../widget/article_notification_card_widget.dart';
import '../widget/message_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.favouriteList}); // Keep it optional

  final Future<List<Article>>? favouriteList;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Article>> articles;
  late List<Article> listArticle;
  final TextEditingController _searchController = TextEditingController();


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

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  //Method fetch data by category
  void fetchDataByCategory(String category) {
    setState(() {
      articles = APIService().getCategoryNews(category);
    });
  }


  @override
  Widget build(BuildContext context) {

    //PROVIDER
    final themeProvider = ThemeProvider.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [


                const SizedBox(height: 20,),

                //SEARCH & NOTIFICATION
                SizedBox(
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
                            controller: _searchController,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: textFontContent,
                                fontSize: 15
                            ),
                            decoration: InputDecoration(
                              hintText: 'Dogecoin to the Moon...',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: textFontContent,
                                fontSize: 12,
                                color: themeProvider.isDark ? Colors.white : Colors.black12
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  onPressed: () async {
                                    if(_searchController.text.isEmpty) {
                                      showMessageDialog(context, "Search word is empty", false);
                                    } else {
                                      showMessageDialog(context, "Searching ...", true);
                                      await Future.delayed(const Duration(seconds: 4));
                                      Navigator.push(context, SlidePageRoute(page: SearchScreen(searchController: _searchController), beginOffset: const Offset(1,0), endOffset: Offset.zero, duration: const Duration(milliseconds: 1000)));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.search_outlined,
                                    color: themeProvider.isDark ? Colors.white : Colors.black12,
                                    size: 25,
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
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
                                  beginOffset: const Offset(1, 0),
                                  endOffset: Offset.zero,
                                  duration: const Duration(milliseconds: 1000)));
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
                        articles: articles).animate()
                        .fade(delay: 2000.ms)
                        .slideY(begin: 1.0, end: 0, duration: 800.ms), // Use the ArticleList widget
                  ),
                ),

              ],
            ),

            //BOTTOM NAVBAR
            const BottomNavbarWidget(indexStaying: 0,),
          ],
        ),
      ),
    );
  }
}
