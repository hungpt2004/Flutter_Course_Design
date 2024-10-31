import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_app_flutter/repository/course_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class CourseProvider extends ChangeNotifier {

  final CourseRepository courseRepository = CourseRepository();

  List<Course> _courses = [];

  // GETTER
  List<Course> get courses => _courses;

  // GET ALL COURSES
  Future<void> fetchAllCourses() async {
    _courses = await courseRepository.getAllCourses();
    debugPrint("DEBUG: ${_courses.length}");
    notifyListeners();
  }

  // STATIC CALL PROVIDER
  static CourseProvider stateCourseManagement(BuildContext context, {listen = true}){
    return Provider.of<CourseProvider>(context,listen: listen);
  }

}