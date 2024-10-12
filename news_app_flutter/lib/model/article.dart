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
    this.urlToImage, // urlToImage can be null
    required this.publishedAt,
    this.content, // content can be null
    this.isFavourite = false
  });

  // Phương thức ánh xạ JSON vào đối tượng Article
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? 'Unknown', // Nếu không có author, để mặc định là 'Unknown'
      title: json['title'], // Nếu không có title, để mặc định là 'No Title'
      description: json['description'] ?? 'Unknown', // Có thể null
      url: json['url'] ?? 'Default url', // Nếu không có url, để mặc định là chuỗi rỗng
      urlToImage: json['urlToImage'] ?? 'https://cdn.pixabay.com/photo/2016/02/01/00/56/news-1172463_640.jpg', // URL ảnh mặc định
      publishedAt: json['publishedAt'], // Nếu không có ngày, để mặc định là 'No Date'
      content: json['content'] ?? 'No Content', // Có thể null
    );
  }
}