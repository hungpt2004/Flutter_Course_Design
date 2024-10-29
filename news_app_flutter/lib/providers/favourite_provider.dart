import 'package:flutter/cupertino.dart';
import 'package:news_app_flutter/model/article.dart';
import 'package:provider/provider.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<Article> _articles = [];
  List<Article> get articles => _articles;

  void toggleAddFavourite(Article article){
    article.isFavourite = true;
    _articles.add(article);
    notifyListeners();
  }

  void toggleRemoveFavourite(Article article){
    article.isFavourite = false;
    _articles.remove(article);
    notifyListeners();
  }

  static FavouriteProvider of(BuildContext context, {listen = true}){
    return Provider.of(context, listen: listen);
  }


}