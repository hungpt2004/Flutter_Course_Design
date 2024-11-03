import 'content.dart';

class Document {
  final String docID;
  final String title;
  final String url;
  final List<Content> contents;

  Document({required this.docID,required this.title,required this.url, required this.contents});


  factory Document.fromFirebase(Map<String, dynamic> firebase, String docID, List<Content> contentList) {
    return Document(docID: docID ,title: firebase['title'], url: firebase['url'],contents: contentList);
  }


}