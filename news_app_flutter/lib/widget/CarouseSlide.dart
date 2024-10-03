import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/Constant.dart';
import 'package:news_app_flutter/service/NewsDataAPI.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_app_flutter/widget/ArticleCard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/Article.dart';

class LatestNewsSlideWidget extends StatefulWidget {
  const LatestNewsSlideWidget({super.key});

  @override
  State<LatestNewsSlideWidget> createState() => _LatestNewsSlideWidgetState();
}

class _LatestNewsSlideWidgetState extends State<LatestNewsSlideWidget> {
  late Future<List<Article>> articles;
  final PageController _pageController = PageController();
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print(snapshot.data!.length);
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Have an error when get data in slide"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text("No data in slide"),
          );
        }

        //WIDGET
        final List<Article> articleList = snapshot.data!;
        return Column(children: [
          CarouselSlider.builder(
            itemCount: articleList.length,
            itemBuilder: (context, index, realIndex) {
              final articleIndex = articleList[index];
              return ArticleCardWidget(articleIndex: articleIndex);
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
                  0.9, // Điều chỉnh này có thể thay đổi để phù hợp với thiết kế của bạn
              enlargeCenterPage: true, // Tắt phóng to trang ở giữa
            ),
          ),

          SizedBox(
            height: 10,
          ),

          //DOT
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: articleList.length,
              effect: WormEffect(
                  activeDotColor: primaryColors, dotHeight: 8, dotWidth: 12),
            ),
          ),


        ]);
      },
    );
  }
}
