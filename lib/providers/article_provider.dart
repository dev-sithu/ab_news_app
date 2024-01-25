import 'package:ab_news_app/database/database.dart';
import 'package:flutter/material.dart';

class ArticleProvider extends ChangeNotifier {
  var _articles = <Article>[];

  /// Getter for _articles
  List<Article> get articles => _articles;

  /// Setter for _articles
  set articles(List<Article> data) {
    _articles = data;
    notifyListeners();
  }
}
