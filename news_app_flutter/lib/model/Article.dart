import 'Source.dart';

class Article {
  final Source source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage, // urlToImage can be null
    required this.publishedAt,
    this.content, // content can be null
  });

  //Method map object
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? 'Unknown', // Default to empty string if null
      title: json['title'] ?? 'No Title', // Default to 'No Title' if null
      description: json['description'] ?? '', // Default to empty string if null
      url: json['url'] ?? '', // Default to empty string if null
      urlToImage: json['urlToImage'] ?? 'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg', // This can be null
      publishedAt: json['publishedAt'] ?? 'No Date', // Default to 'No Date' if null
      content: json['content'], // This can be null
    );
  }
}
