import 'package:ab_news_app/database/database.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  var favorites = <Article>[];

    void toggleFavorite(Article current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners();
  }
}
