import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/constant/constant.dart';
import '../model/article.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  const NewsDetails({super.key, required this.articleIndex});

  final Article articleIndex;

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final Article article = widget.articleIndex;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                //IMAGE
                Container(
                  width: double.infinity,
                  height: 370,
                  child: Image.network(
                    article.urlToImage ??
                        'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),

            //CONTENT
            Positioned(
              top: 330, // Điều chỉnh độ cao để đè lên phần hình ảnh
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [

                    const SizedBox(height: 70),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              article.content ?? '',
                              style: const TextStyle(
                                fontFamily: textFontContent,
                                fontSize: 17,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 30, right: 30, bottom: 30),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              article.description ?? '',
                              style: const TextStyle(
                                  fontFamily: textFontContent,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //CONTAINER OVERLAY
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10.0, sigmaY: 10.0), // Điều chỉnh độ mờ
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300]!
                            .withOpacity(0.5), // Thay đổi độ trong suốt
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    _formatDate(article
                                        .publishedAt), // Thêm nội dung ở đây
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: textFontContent,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    article.title ?? 'Unknown', // Thêm nội dung ở đây
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: textFontContent,
                                        fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Published by ${article.author}", // Thêm nội dung ở đây
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: textFontContent,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //BACK BUTTON
            Positioned(
              top: 30,
              left: 20,
              child: GestureDetector(
                onTap: () => {
                  Navigator.pop(context),
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 12, top: 10, bottom: 10, right: 5),
                    child: Center(child: Icon(Icons.arrow_back_ios)),
                  ),
                ),
              ),
            ),

            //LOVE BUTTON
            Positioned(
              bottom: 60,
              right: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primaryColors,
                ),
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  icon: Icon(Icons.favorite_border_outlined, color: isFavourite ? tertiaryColors : Colors.white,),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  //CONVERT FOMART DATE
  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('EEEE, dd MMMM yyyy').format(parsedDate);
  }

}
