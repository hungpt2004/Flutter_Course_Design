import 'package:flutter/widgets.dart';
import 'package:news_app_flutter/model/article.dart';
import 'package:provider/provider.dart';

class HistoryProvider extends ChangeNotifier{
    List<Article> _articles = [];
    List<Article> get articles => _articles;

    void toggleHistoryNews(Article article){
      bool existNews = _articles.any((items) => items.title == article.title);
      if(!existNews){
        _articles.add(article);
      }
      notifyListeners();
    }

    static HistoryProvider of(BuildContext context, {listen = true}){
      return Provider.of<HistoryProvider>(context,listen: listen);
    }

}