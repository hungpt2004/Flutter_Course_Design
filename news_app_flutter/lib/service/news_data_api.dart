import 'dart:convert';

import 'package:news_app_flutter/model/article.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String apiKey = "1af72ee6d2b04f4cbc9e73f5cdc17d60";
  final String baseUrl = "https://newsapi.org/v2";
  final String country = "us";

  //Method fetch data top-headlines, latest
  Future<List<Article>> getLatestNews() async {
    // URL
    final String url = "$baseUrl/top-headlines?country=us&apiKey=$apiKey";

    try {
      final dataResponse = await http.get(Uri.parse(url));

      if (dataResponse.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(dataResponse.body);
        final List<dynamic> articlesJson = jsonData['articles'];

        print("Response body: ${dataResponse.body}");

        return articlesJson.map((json) => Article.fromJson(json)).toList();
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
        "$baseUrl/top-headlines?country=us&category=$category&apiKey=$apiKey";

    try {
      final dataResponse = await http.get(Uri.parse(url));

      //If success
      if (dataResponse.statusCode == 200) {
        //To save object follow MAP
        final Map<String, dynamic> jsonData = json.decode(dataResponse.body);
        //To save object convert from API
        final List<dynamic> articlesJson = jsonData['articles'];

        print("Response body: ${dataResponse.body}");

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

        print("Response body: ${dataResponse.body}");

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
