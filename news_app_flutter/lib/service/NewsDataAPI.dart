import 'dart:convert';

import 'package:news_app_flutter/model/Article.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String apiKey = "86c29130de2e467b9e259ef049db36aa";
  final String baseUrl = "https://newsapi.org/v2";
  final String country = "us";

  //Method fetch data top-headlines, latest
  Future<List<Article>> getLatestNews() async {
    // URL
    final String url = "$baseUrl/top-headlines?country=$country&apiKey=$apiKey";

    try {
      final dataResponse = await http.get(Uri.parse(url));

      if (dataResponse.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(dataResponse.body);
        final List<dynamic> articlesJson = jsonData['articles'];

        // Chuyển đổi đối tượng json -> object article, chỉ lấy các bài có urlToImage không null
        List<Article> articles = [];
        for (var json in articlesJson) {
          // Kiểm tra nếu urlToImage không phải là null
          if (json['urlToImage'] != null) {
            articles.add(Article.fromJson(json));
          }
        }

        return articles; // Trả về danh sách các bài viết đã lọc
      } else {
        throw Exception("Có lỗi khi lấy dữ liệu tin tức mới nhất");
      }
    } catch (e) {
      print("Có lỗi với URL: $e");
      throw Exception(e.toString());
    }
  }

  //Method fetch data top headlines by category, button category
  Future<List<Article>> getCategoryNews(String category) async {
    //Url
    final String url =
        "$baseUrl/top-headlines?country=$country&category=$category&apiKey=$apiKey";

    try {
      final dataResponse = await http.get(Uri.parse(url));

      //If success
      if (dataResponse.statusCode == 200) {
        //To save object follow MAP
        final Map<String, dynamic> jsonData = json.decode(dataResponse.body);
        //To save object convert from API
        final List<dynamic> articlesJson = jsonData['articles'];

        print(dataResponse.body);

        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception("Have an error when get data category news");
      }
    } catch (e) {
      print("Have an error of url");
      throw Exception(e.toString());
    }
  }

  //Method fetch everything data by keyword, search field
  Future<List<Article>> getEverythingNews(String keyWord) async {
    //Url
    final String url = "$baseUrl/everything?q=$keyWord&apiKey=$apiKey";
    try {
      final dataResponse = await http.get(Uri.parse(url));

      //If success
      if (dataResponse.statusCode == 200) {
        //To save object follow MAP
        final Map<String, dynamic> jsonData = json.decode(dataResponse.body);
        //To save object convert from API
        final List<dynamic> articlesJson = jsonData['articles'];

        return articlesJson.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception("Have an error when get data category news");
      }
    } catch (e) {
      print("Have an error of url");
      throw Exception(e.toString());
    }
  }
}
