// import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/database/database.dart';
import 'package:flutter/material.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _cachedArticles = <Article>[];
  /// article id list with pagination
  /// _articles[0] = List<int>
  /// _articles[1] = List<int>
  /// ....
  /// _articles[n] = List<int>
  List<List<int>> _articles = [];

  /// Getter for _cachedArticles
  List<Article> get cachedArticles => _cachedArticles;

  /// Setter for _cachedArticles
  set cachedArticles(List<Article> data) {
    _cachedArticles = data;
    // notifyListeners();
  }

  /// Getter for _articles
  List<List<int>> get articles => _articles;

  /// Setter for _articles
  set articles(List<List<int>> data) {
    _articles = data;
    notifyListeners();
  }
}
