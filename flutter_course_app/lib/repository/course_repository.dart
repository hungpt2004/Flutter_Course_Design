import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/models/course.dart';
import 'package:flutter/cupertino.dart';

import '../models/video.dart';

class CourseRepository {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  //-----------------------------------------COURSE-----------------------------------------

  //GET ALL COURSE
  Future<List<Course>> getAllCourses() async {
    List<Course> courses = [];

    try {
      QuerySnapshot snapshot =
          await firebaseFireStore.collection('courses').get();
      debugPrint("LENGTH OF COURSES FROM FIRESTORE: ${snapshot.docs.length}");

      for (var courseDoc in snapshot.docs) {

        String courseID = courseDoc.id;
        List<Video> videos = await getAllVideos(courseID);
        debugPrint("LENGTH OF COURSES FROM VIDEOS: ${videos.length}");

        Course course = Course.fromFirebase(courseDoc.data() as Map<String, dynamic>, courseID, videos);
        courses.add(course);
      }


    } catch (e) {
      throw Exception("Error fetch all of course ${e.toString()}");
    }

    return courses;
  }

  // GET COURSE BY COURSE ID
  Future<Course?> getCourseByID(String courseID) async {
    try {
      DocumentSnapshot doc =
          await firebaseFireStore.collection('courses').doc(courseID).get();
      if (doc.exists) {
        List<Video> videos = await getAllVideos(courseID);
        return Course.fromFirebase(
            doc.data() as Map<String, dynamic>, doc.id, videos);
      }
    } catch (e) {
      throw Exception("Error fetch video of course ${e.toString()}");
    }
    return null;
  }

  //-----------------------------------------VIDEO-------------------------------------------

  // GET ALL VIDEO OF COURSE
  Future<List<Video>> getAllVideos(String courseID) async {
    QuerySnapshot snapshot = await firebaseFireStore
        .collection('courses')
        .doc(courseID)
        .collection('videos')
        .get();
    return snapshot.docs
        .map((QueryDocumentSnapshot doc) =>
            Video.fromFirebase(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

}
