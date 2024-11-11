import 'package:course_app_flutter/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/content.dart';
import '../models/document.dart';

class DocumentProvider extends ChangeNotifier {

  final DocumentRepository documentRepository = DocumentRepository();

  List<Document> _documents = [];
  Document? _currentDocs;
  Content? _currentContent;

  List<Document> get documents => _documents;
  Content? get content => _currentContent;
  Document? get document => _currentDocs;

  // GET ALL DOCUMENTS
  Future<void> getAllDocuments() async {
    _documents = await documentRepository.getAllDocuments();
    notifyListeners();
  }

  Future<void> toggleReadMore(Content newContent) async {
    _currentContent = newContent;
    notifyListeners();
  }

  Future<void> toggleDocument(Document document) async {
    _currentDocs = document;
    notifyListeners();
  }


  static DocumentProvider documentStateManagement(BuildContext context, {listen = true}) {
    return Provider.of<DocumentProvider>(context, listen: listen);
  }

}