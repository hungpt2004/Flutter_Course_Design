import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/article.dart';
import '../service/news_data_api.dart';
import '../widget/button_category_widget.dart';
import '../widget/slide_page_route_widget.dart';

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
  void fetchDataByCategory(String category) {
    setState(() {
      articles = APIService().getCategoryNews(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

          SizedBox(height: 10,),

          //SEARCH & NOTIFICATION
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 65,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 5,
                    child: TextFormField(
                      controller: widget.searchController,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: textFontContent,
                          fontSize: 15
                      ),
                      decoration: InputDecoration(
                        hintText: 'Dogecoin to the Moon...',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: textFontContent,
                            fontSize: 12
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                              (widget.searchController == null ? Icons.search_outlined : Icons.clear),
                              color: Colors.grey[500],
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

          SizedBox(height: 10,),


          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: TextButton(onPressed: (){}, child: Text("Filter"),),
          ),

          //BUTTON CATEGORY
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ButtonCategory(onSelected: fetchDataByCategory),
          ),

        ],
      ),
    );
  }
}
