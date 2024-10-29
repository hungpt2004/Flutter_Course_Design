import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/screen/details/notification_screen.dart';
import 'package:news_app_flutter/screen/details/search_screen.dart';
import 'package:news_app_flutter/service/news_data_api.dart';
import 'package:news_app_flutter/widget/card/article_category_card_widget.dart';
import 'package:news_app_flutter/widget/bottom_navbar/bottom_navbar_widget.dart';
import 'package:news_app_flutter/widget/button/button_category_widget.dart';
import 'package:news_app_flutter/widget/slide/carousel_slide_widget.dart';
import 'package:news_app_flutter/widget/route/slide_page_route_widget.dart';
import '../constant/constant.dart';
import '../model/article.dart';
import '../theme/style.dart';
import '../widget/card/article_notification_card_widget.dart';

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
  bool isLoading = false;

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //Method fetch data by category
  void fetchDataByCategory(String category) {
    setState(() {
      articles = APIService().getCategoryNews(category);
    });
  }

  _startLoad() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    //PROVIDER
    final themeProvider = ThemeProvider.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: themeProvider.isDark ? Colors.black : Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                Style.space(20, 0),
                //SEARCH & NOTIFICATION
                SizedBox(
                  width: Style.styleWidthDevice(context),
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            flex: 3,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(40))),
                                    fixedSize: const WidgetStatePropertyAll(
                                        Size(double.infinity, 80)),
                                    elevation: const WidgetStatePropertyAll(4),
                                    backgroundColor:
                                    const WidgetStatePropertyAll(primaryColors)),
                                onPressed: () async {
                                  await _startLoad();
                                  Style.navigatorPush(context, const SearchScreen());
                                },
                                child: isLoading ? Row( mainAxisAlignment: MainAxisAlignment.center,children: [Style.loading()],) : Row(
                                  children: [
                                    const Icon(
                                      Icons.search_outlined,
                                      color: Colors.white,
                                    ),
                                    Style.space(0, 10),
                                    Style.styleContentOnCard(
                                        "Search", 18)
                                  ],
                                ))),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            style: const ButtonStyle(
                              elevation: WidgetStatePropertyAll(4),
                              shape: WidgetStatePropertyAll(CircleBorder()),
                              backgroundColor: WidgetStatePropertyAll(primaryColors),
                              fixedSize: WidgetStatePropertyAll(Size(50, 80)),
                            ),
                            onPressed: () {
                              Style.navigatorPush(
                                  context, const NotificationScreen());
                            },
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Style.space(10, 0),
                //BUTTON LATEST
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Style.styleTitleText("Latest News", 30, themeProvider),
                      TextButton(
                        onPressed: () {
                          Style.navigatorPush(context, ArticleNotificationCard(articleList: listArticle));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Style.styleContentText("See All", 14, themeProvider),
                            Style.space(5, 0),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: themeProvider.isDark
                                  ? Colors.white
                                  : Colors.black,
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ArticleListCategory(articles: articles)
                        .animate()
                        .fade(delay: 800.ms)
                        .slideY(
                        begin: 1.0,
                        end: 0,
                        duration: 800.ms), // Use the ArticleList widget
                  ),
                ),
              ],
            ),

            //BOTTOM NAVBAR
            const BottomNavbarWidget(
              indexStaying: 0,
            ),
          ],
        ),
      ),
    );
  }
}

