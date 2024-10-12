import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app_flutter/constant/constant.dart';
import 'package:news_app_flutter/providers/theme_provider.dart';
import 'package:news_app_flutter/screen/details/search_screen.dart';
import 'package:news_app_flutter/screen/home_screen.dart';
import 'package:news_app_flutter/widget/message_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/category.dart';
import '../../widget/slide_page_route_widget.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key, required this.isDark});

  final bool isDark;

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  // bool isDark = false;
  int activeIndex = 0;

  final List<Category> category = [
    Category(name: "Health", urlImage: "assets/images/health.jpg"),
    Category(name: "Sport", urlImage: "assets/images/sport.jpg"),
    Category(name: "Business", urlImage: "assets/images/business.jpg"),
    Category(name: "Fashion", urlImage: "assets/images/fashion.jpg"),
    Category(name: "Security", urlImage: "assets/images/security.jpg"),
  ];

  Future<void> _lauchUrl() async {
    const url =
        "https://www.figma.com/design/TN26gsemHxQ5O0xfPRKyp5/News-App-UI-Kit-(Community)?node-id=89-1";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMessageDialog(context, "Could not launch url", false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    return Scaffold(
      body: Column(
        children: [

          //BUTTON INFOR AND DARK LIGHT
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Tooltip(
                    message: 'Information about app',
                    child: IconButton(
                        onPressed: () {
                          _lauchUrl();
                        },
                        icon: const Icon(Icons.info))),
                Tooltip(
                  message: 'Change brightness mode',
                  child: IconButton(
                    isSelected: themeProvider.isDark,
                    onPressed: () {
                      Future.delayed(const Duration(seconds: 5));
                      themeProvider.toggleTheme();
                    },
                    icon: Icon(
                      themeProvider.isDark
                          ? Icons.brightness_2_rounded
                          : Icons.sunny, color: themeProvider.isDark ? Colors.yellow : Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          //LOGO EARTH
          Center(
            child: Container(
              height: 200,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: themeProvider.isDark ? Colors.indigo.withOpacity(0.5) : Colors.black38.withOpacity(0.5),
                  offset: Offset(0,0),
                  blurStyle: BlurStyle.normal,
                  blurRadius: 30,
                )
              ]),
              child: AnimatedBuilder(
                animation: _controller,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset("assets/images/earth.png"),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * 3.14,
                    child: child,
                  );
                },
              ),
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          //GACH NGANG
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Divider(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),

          //TITLE
          SizedBox(
              height: 290,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      _TextStyle("Breaking Boundaries with Media", 20, false,
                          themeProvider.isDark),
                      const SizedBox(
                        height: 16,
                      ),
                      //SLIDE BUILDER
                      CarouselSlider.builder(
                        itemCount: category.length,
                        itemBuilder: (context, index, realIndex) {
                          final categoryIndex = category[index];
                          return _Card(categoryIndex);
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
                              0.6, // Điều chỉnh này có thể thay đổi để phù hợp với thiết kế của bạn
                          enlargeCenterPage: true, // Tắt phóng to trang ở giữa
                        ),
                      ),
                    ],
                  ))),

          //HEADING
          Center(
            child: _TextStyle("Breaking News", 50, false, themeProvider.isDark),
          ),

          const SizedBox(
            height: 50,
          ),

          //BUTTON START
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(2, 5))
              ]),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        themeProvider.isDark ? Colors.white : primaryColors),
                    animationDuration: const Duration(seconds: 2)),
                onPressed: () {
                  Navigator.push(
                      context,
                      SlidePageRoute(
                          page: const HomeScreen(),
                          beginOffset: const Offset(1, 0),
                          endOffset: Offset.zero,
                          duration: const Duration(milliseconds: 1000)));
                },
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: textFontContent,
                      fontWeight: FontWeight.w600,
                      color:
                          themeProvider.isDark ? primaryColors : Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _TextStyle(String message, double size, bool isTitle, bool statusTheme) {
  return Text(
    message,
    style: TextStyle(
        fontSize: size,
        fontFamily: isTitle ? textFontContent : textFontTitle,
        fontWeight: FontWeight.w400,
        color: !statusTheme ? primaryColors : Colors.white),
  );
}

Widget _Card(Category category) {
  return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(category.urlImage), fit: BoxFit.cover)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.3)),
        child: Center(
          child: Text(
            category.name,
            style: const TextStyle(
                fontFamily: textFontTitle,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ));
}
