import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app_flutter/widget/article_notification_card_widget.dart';

import '../../constant/constant.dart';
import '../../model/article.dart';
import '../../service/news_data_api.dart';
import '../../widget/article_category_card_widget.dart';
import '../../widget/button_category_widget.dart';
import '../../widget/slide_page_route_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Article>> articles;

  @override
  void initState() {
    super.initState();
    articles = APIService().getLatestNews();
  }

  //Method fetch data by category
  Future<void> fetchDataByCategory(String category) async {
    setState(() {
      articles = APIService().getCategoryNews(category);
    });
  }

  //Method fetch data by keyword
  Future<void> fetchDataByKeyword(String keyword) async {
    setState(() {
       articles = APIService().getEverythingNews(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ListView(
          children: [
            const SizedBox(
              height: 10,
            ),

            //SEARCH & NOTIFICATION
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: widget.searchController,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: textFontContent,
                            fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Dogecoin to the Moon...',
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: textFontContent,
                              fontSize: 12),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child:

                            widget.searchController.text == ""

                                ? IconButton(
                              onPressed: () async {
                                await fetchDataByKeyword(widget.searchController.text);
                              },
                              icon: const Icon(Icons.search_outlined,
                                color: primaryColors,
                                size: 25,
                              ),
                            )
                                : IconButton(
                              onPressed: () {
                                  Navigator.pop(context);
                              },
                              icon: const Icon(Icons.clear,
                                color: primaryColors,
                                size: 25,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                              color: primaryColors,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: ElevatedButton(
                        onPressed: () {
                          _showModalFilter(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColors),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(9.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "Filter",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: textFontContent,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 4,
                    child: ButtonCategory(
                      onSelected: fetchDataByCategory,
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ArticleListCategory(articles: articles)
                  .animate()
                  .fade(delay: 2000.ms)
                  .slideY(
                      begin: 1.0,
                      end: 0,
                      duration: 1000.ms), // Use the ArticleList widget
            ),
          ],
        ),
      ]),
    );
  }

  void _showModalFilter(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.grey[100],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        )),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //TASK BAR NGANG
                    Center(
                      child: Container(
                        width: 70,
                        height: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Filter",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: textFontContent,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            side: MaterialStatePropertyAll(
                              BorderSide(color: Colors.grey.withOpacity(0.5)),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    "assets/images/trash_small.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      8), // Thêm khoảng cách giữa hình ảnh và text
                              _contentText("Reset"),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_contentText("Sort By")],
                    ),

                    Row(
                      children: [
                        _textButtonStyle("Recommended", () {}),
                        _textButtonStyle("Latest", () {}),
                        _textButtonStyle("Most Viewed", () {}),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Row(
                      children: [
                        _textButtonStyle("Channel", () {}),
                        _textButtonStyle("Following", () {}),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                        margin: const EdgeInsets.only(left: 5, bottom: 10),
                        width: MediaQuery.of(context).size.width * 0.905,
                        child: _buttonSubmit("Save", () {}))
                  ],
                )
              ],
            ),
          );
        });
  }
}

Widget _textButtonStyle(String text, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: TextButton(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
            side: MaterialStatePropertyAll(BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ))),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 14,
              fontFamily: textFontContent,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        )),
  );
}

Widget _buttonSubmit(String text, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: TextButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(primaryColors),
            side: MaterialStatePropertyAll(BorderSide(
              color: primaryColors,
            ))),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18,
              fontFamily: textFontContent,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        )),
  );
}

Widget _contentText(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 14,
        fontFamily: textFontContent,
        fontWeight: FontWeight.w400,
        color: Colors.black),
  );
}
