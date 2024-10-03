import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/widget/ButtonCategory.dart';
import 'package:news_app_flutter/widget/CarouseSlide.dart';
import '../constant/Constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
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
                          // controller: ,
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
                                  borderSide: BorderSide(
                                    color: Colors.grey[200] ?? Colors.grey,
                                    width: 0,
                                  ))),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: primaryColors),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),

                const SizedBox(height: 15,),

                //BUTTON LATEST
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Latest News",
                        style: TextStyle(
                            fontFamily: textFontTitle,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "See All",
                              style: TextStyle(
                                  color: secondaryColors,
                                  fontFamily: textFontContent,
                                  fontSize: 16
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: secondaryColors,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 15,),
                
                //SLIDE
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: LatestNewsSlideWidget(),
                ),

                //BUTTON CATEGORY
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: ButtonCategory(),
                ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
