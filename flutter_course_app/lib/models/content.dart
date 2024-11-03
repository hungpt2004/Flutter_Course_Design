class Content {
  final String contentID;
  final String title;
  final String description;

  Content({required this.contentID,required this.title,required this.description});

  factory Content.fromFirebase(Map<String, dynamic> firebase, String id) {
    return Content(contentID: id, title: firebase['title'], description: firebase['description']);
  }


}