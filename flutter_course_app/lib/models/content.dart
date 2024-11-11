class Content {
  final String contentID;
  final String title;
  final String description;
  final String author;
  final String createdAt;
  final String bookUrl;

  Content(
      {required this.contentID,
      required this.title,
      required this.description,
      required this.author,
      required this.createdAt,
      required this.bookUrl});

  factory Content.fromFirebase(Map<String, dynamic> firebase, String id) {
    return Content(
        contentID: id,
        title: firebase['title'],
        author: firebase['author'],
        bookUrl: firebase['book_url'],
        createdAt: firebase['created_at'],
        description: firebase['description']);
  }
}
