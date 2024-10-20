import 'source.dart';

class Article {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;
  bool isFavourite = false;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.isFavourite = false
  });


  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? 'Unknown',
      title: json['title'],
      description: json['description'] ?? 'Unknown',
      url: json['url'] ?? 'Default url',
      urlToImage: json['urlToImage'] ?? 'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg',
      publishedAt: json['publishedAt'],
      content: json['content'] ?? 'No Content',
    );
  }

}