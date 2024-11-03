import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/content.dart';
import '../models/document.dart';

class DocumentRepository {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<List<Document>> getAllDocuments() async {
    List<Document> documents = [];
    try {
      QuerySnapshot querySnapshot =
          await firebaseFireStore.collection('documents').get();
      for (var doc in querySnapshot.docs) {
        final documentID = doc.id;
        List<Content> contents = await getAllContents(documentID);
        Document document = Document.fromFirebase(doc.data() as Map<String,dynamic>,documentID, contents);
        documents.add(document);
      }
    } catch (e) {
      throw Exception("Error in document ${e.toString()}");
    }
    return documents;
  }

  Future<List<Content>> getAllContents(String docID) async {
    QuerySnapshot querySnapshot = await firebaseFireStore
        .collection('documents')
        .doc(docID)
        .collection('contents')
        .get();
    return querySnapshot.docs
        .map((QueryDocumentSnapshot doc) =>
            Content.fromFirebase(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
