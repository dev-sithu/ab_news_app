import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/services/favorite_service.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final AuthProvider ? _authProvider;
  var favorites = <Article>[];

  /// Constructure
  FavoriteProvider(this._authProvider) {
    if (_authProvider != null && _authProvider.isUserLoggedIn) {
      loadFavorites();
    }
  }

  /// Load favorite articles from db into state
  void loadFavorites() async {
    favorites = await getIt<FavoriteService>().findByUser(_authProvider?.user['id']);
  }

  /// Add to/Remove from favorites tate
  void toggleFavorite(Article current) {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }

    notifyListeners(); // Notify to all listeners about changes
  }
}
