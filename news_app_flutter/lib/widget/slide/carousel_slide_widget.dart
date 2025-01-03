import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/service/news_data_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app_flutter/widget/card/article_card_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../model/article.dart';
import '../../theme/style.dart';

class CouselSlideWidget extends StatefulWidget {
  const CouselSlideWidget({super.key});

  final dotSize = 4;

  @override
  State<CouselSlideWidget> createState() => _LatestNewsSlideWidgetState();
}

class _LatestNewsSlideWidgetState extends State<CouselSlideWidget> {
  late Future<List<Article>> articles;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = ThemeProvider.of(context);

    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Style.snapshotLoading(themeProvider);
        }
        if (snapshot.hasError) {
          return Style.snapshotError(themeProvider);
        }
        if (!snapshot.hasData) {
          return Style.snapshotDataNull(themeProvider);
        }

        //WIDGET
        final List<Article> articleList = snapshot.data ?? [];

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            //SLIDE BUILDER
            CarouselSlider.builder(
              itemCount: articleList.length,
              itemBuilder: (context, index, realIndex) {
                final articleIndex = articleList[index];
                return ArticleCardWidget(
                  articleIndex: articleIndex,
                );
              },
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.fastOutSlowIn),
            ),

            const SizedBox(
              height: 10,
            ),

            //DOT
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedSmoothIndicator(
                duration: const Duration(milliseconds: 800),
                activeIndex: activeIndex,
                count: widget.dotSize,
                effect: const WormEffect(
                  activeDotColor: primaryColors,
                  dotHeight: 5,
                  dotWidth: 15,
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
