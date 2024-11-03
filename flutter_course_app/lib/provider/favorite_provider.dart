import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class FavoriteProvider extends ChangeNotifier {

  List<Course> _favorites = [];
  bool _isFavorite = false;

  List<Course> get favorites => _favorites;
  bool get isFavorite => _isFavorite;

  bool addFavorite(Course course){
    bool check = _favorites.any((items) => items.courseId == course.courseId);
    if(check){
      _isFavorite = false;
      return false;
    } else {
      _favorites.add(course);
      _isFavorite = true;
      notifyListeners();
      return true;
    }
  }

  bool removeFavorite(Course course){
    bool check = _favorites.any((items) => items.courseId == course.courseId);
    if(check){
      _favorites.remove(course);
      _isFavorite = false;
      notifyListeners();
      return true;
    } else {
      _isFavorite = false;
      return false;
    }
  }

  static FavoriteProvider stateFavoriteManagement(BuildContext context, {listen = true}){
    return Provider.of<FavoriteProvider>(context,listen: listen);
  }

}