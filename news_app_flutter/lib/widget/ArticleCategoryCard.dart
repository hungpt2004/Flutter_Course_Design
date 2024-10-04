import 'package:flutter/material.dart';
import 'package:news_app_flutter/constant/Constant.dart';
import 'package:news_app_flutter/model/Article.dart';

class ArticleListCategory extends StatelessWidget {
  final Future<List<Article>> articles;

  const ArticleListCategory({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: articles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Have an error when fetching data in Article Category'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Have no data in Article Category'));
        }

        final articlesData = snapshot.data!;
        print(articlesData.length);
        return ListView.builder(
          itemCount: articlesData.length,
          itemBuilder: (context, index) {
            final article = articlesData[index];
            return SingleChildScrollView(
              child: Stack(
                children: [
              
                  //IMAGE
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10), // Thêm góc bo cho Container
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      //IMAGE
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          article.urlToImage ??
                              'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),

                  //OVERLAY
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.2), // Semi-transparent black overlay
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            );
          },
        );
      },
    );
  }
}
