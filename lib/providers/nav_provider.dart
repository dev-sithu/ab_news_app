import 'package:ab_news_app/pages/home.dart';
import 'package:ab_news_app/pages/favorites.dart';
import 'package:ab_news_app/pages/login.dart';
import 'package:ab_news_app/pages/mypage.dart';
import 'package:ab_news_app/pages/register.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  final AuthProvider ? _authProvider;
  List<Widget> _pages = [];

  NavProvider(this._authProvider) {
    if (_authProvider != null && _authProvider.isUserLoggedIn) {
      mypageNav();
    } else {
      registerNav();
    }
  }

  void loginNav() {
    _pages = [
      const Home(),
      const Favorites(),
      const Login(),
    ];

    notifyListeners();
  }

  void registerNav() {
    _pages = [
      const Home(),
      const Favorites(),
      const Register(),
    ];

    notifyListeners();
  }

  void mypageNav() {
    _pages = [
      const Home(),
      const Favorites(),
      const Mypage(),
    ];

    notifyListeners();
  }

  /// Getter for _pages
  List<Widget> get pages => _pages;
}
