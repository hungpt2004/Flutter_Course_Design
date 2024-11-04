import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/repository/auth_repository.dart';
import 'package:course_app_flutter/repository/course_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../models/video.dart';

class CourseProvider extends ChangeNotifier {

  final CourseRepository courseRepository = CourseRepository();

  List<Course> _courses = [];

  late Course _currentCourse;


  // GETTER
  List<Course> get courses => _courses;
  Course get currentCourse => _currentCourse;

  // GET ALL COURSES
  Future<void> fetchAllCourses() async {
    _courses = await courseRepository.getAllCourses();
    debugPrint("DEBUG IN PROVIDER: ${_courses.length}");
    notifyListeners();
  }

  // JOIN
  Future<void> toggleJoin(Course course) async {
    _currentCourse = course;
    notifyListeners();
  }

  // GET COURSE
  Future<Course?> getCourseByID(String courseID) async {
    return await courseRepository.getCourseByID(courseID);
  }

  // STATIC CALL PROVIDER
  static CourseProvider stateCourseManagement(BuildContext context, {listen = true}){
    return Provider.of<CourseProvider>(context,listen: listen);
  }

}