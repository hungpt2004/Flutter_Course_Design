import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/service/news_data_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app_flutter/widget/article_card_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/article.dart';

class CouselSlideWidget extends StatefulWidget {
  const CouselSlideWidget({super.key});

  final dotSize = 4;

  @override
  State<CouselSlideWidget> createState() => _LatestNewsSlideWidgetState();
}

class _LatestNewsSlideWidgetState extends State<CouselSlideWidget> {
  late Future<List<Article>> articles;
  final PageController _pageController = PageController();
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews(); // Không cần setState
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Have an error when get data in slide"),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text("No data in slide"),
          );
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
                return ArticleCardWidget(articleIndex: articleIndex,);
              },
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction:
                    1, // Điều chỉnh này có thể thay đổi để phù hợp với thiết kế của bạn
                enlargeCenterPage: true, // Tắt phóng to trang ở giữa
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //DOT
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: AnimatedSmoothIndicator(
                duration: Duration(milliseconds: 800),
                activeIndex: activeIndex,
                count: widget.dotSize,
                effect: const WormEffect(
                    activeDotColor: primaryColors, dotHeight: 5, dotWidth: 15, ),
              ),
            ),


          ]),
        );
      },
    );
  }
}
