import 'package:course_app_flutter/repository/document_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/document.dart';

class DocumentProvider extends ChangeNotifier {

  final DocumentRepository documentRepository = DocumentRepository();

  List<Document> _documents = [];

  List<Document> get documents => _documents;

  Future<void> getAllDocuments() async {
    _documents = await documentRepository.getAllDocuments();
    notifyListeners();
  }

  static DocumentProvider documentStateManagement(BuildContext context, {listen = true}) {
    return Provider.of<DocumentProvider>(context, listen: listen);
  }

}