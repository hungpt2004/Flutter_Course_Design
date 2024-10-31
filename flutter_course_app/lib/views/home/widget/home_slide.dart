import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/theme/style/space_style.dart';
import 'package:course_app_flutter/theme/style/style_button.dart';
import 'package:course_app_flutter/theme/style/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/course.dart';

class SlideHome extends StatefulWidget {
  const SlideHome({super.key, required this.isBanner});

  final bool isBanner;

  @override
  State<SlideHome> createState() => _SlideAdvertisementState();
}

class _SlideAdvertisementState extends State<SlideHome> {
  int currentIndex = 0;
  int dotSize = 3;

  List<String> urlImage = [
    "assets/images/ads7.jpg",
    "assets/images/ads4.jpg",
    "assets/images/ads5.jpg",
    "assets/images/ads6.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    final courseProvider = CourseProvider.stateCourseManagement(context);
    final isBannerCheck = widget.isBanner;
    debugPrint("Debug in screen: ${courseProvider.courses.length}");

    return isBannerCheck
        ? FutureBuilder<void>(
            future: courseProvider.fetchAllCourses(),
            builder: (context, snapshot) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courseProvider.courses.length,
                itemBuilder: (context, index) {
                  final courseIndex = courseProvider.courses[index];
                  return cardCourse(courseIndex);
                },
              );
            })
        : Column(children: [
            CarouselSlider.builder(
              itemCount: urlImage.length,
              itemBuilder: (context, index, realIndex) {
                String urlImageIndex = urlImage[index];
                debugPrint("Debug in screen: ${courseProvider.courses.length}");
                return cardAdvertisement(urlImageIndex, context);
              },
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  scrollPhysics: const CarouselScrollPhysics(),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  height: 160),
            ),
            SpaceStyle.boxSpaceHeight(10),
            dotSlide(currentIndex, urlImage)
          ]);
  }
}

Widget cardAdvertisement(String urlImage, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
        width: 327,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: AssetImage(urlImage), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: ButtonStyleApp.normalButton(() {}, "Explore Now",
                  kPrimaryColor, kDefaultColor, kDefaultColor, 15, 12, 15)),
        )),
  );
}

Widget cardCourse(course) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: kDefaultColor, // Thêm màu nền cho dễ nhìn
          boxShadow: [

          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 125,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: course.logo,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(
                        color: kPrimaryColor,
                          value: downloadProgress.progress),),
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(CupertinoIcons.info_circle),
                    );
                  },
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeInCurve: Curves.easeInOut,
                ),
              ),
            ),
            Container(
              height: 110,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Code Programming",style: TextStyleApp.textStyleForm(11, FontWeight.w300, kCardTextColor),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("${course.title}",style: TextStyleApp.textStyleForm(16, FontWeight.w700, kCardTitleColor),),
                      ],
                    ),
                    SpaceStyle.boxSpaceHeight(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("⭐${course.rating} 🕔${course.time}", style: TextStyleApp.textStyleForm(12, FontWeight.w500, kCardTextColor),),
                        ButtonStyleApp.normalButton((){}, "Join", kPrimaryColor, kDefaultColor, kDefaultColor, 15, 15, 10)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
  );
}

Widget dotSlide(currentIndex, List<String> urlImage) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: AnimatedSmoothIndicator(
      duration: const Duration(milliseconds: 800),
      activeIndex: currentIndex,
      count: urlImage.length,
      effect: ExpandingDotsEffect(
        radius: 50,
        spacing: 4,
        activeDotColor: Colors.black.withOpacity(0.6),
        expansionFactor: 2,
        dotHeight: 4,
        dotWidth: 10,
      ),
    ),
  );
}
