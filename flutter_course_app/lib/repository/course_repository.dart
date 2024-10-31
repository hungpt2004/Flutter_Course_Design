import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/models/course.dart';

class CourseRepository {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  // GET ALL
  Future<List<Course>> getAllCourses() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFireStore.collection('courses').get();

      // In ra số lượng tài liệu đã lấy
      print('Number of courses fetched: ${querySnapshot.docs.length}');

      // Kiểm tra dữ liệu từng tài liệu
      for (var doc in querySnapshot.docs) {
        print('Course ID: ${doc.id}, Data: ${doc.data()}');
      }

      return querySnapshot.docs
          .map((QueryDocumentSnapshot doc) =>
              Course.fromFirebase(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching courses: $e');
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }
}
