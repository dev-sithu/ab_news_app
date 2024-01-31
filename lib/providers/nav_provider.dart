import 'package:ab_news_app/pages/favorites.dart';
import 'package:ab_news_app/pages/home_pager.dart';
import 'package:ab_news_app/pages/login.dart';
import 'package:ab_news_app/pages/mypage.dart';
import 'package:ab_news_app/pages/register.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  final AuthProvider ? _authProvider;
  List<Widget> _pages = [];
  int _currentIndex = 0;

  NavProvider(this._authProvider) {
    if (_authProvider != null && _authProvider.isUserLoggedIn) {
      mypageNav();
    } else {
      registerNav();
    }
  }

  void loginNav() {
    _pages = [
      const HomePager(),
      const Favorites(),
      const Login(),
    ];

    notifyListeners();
  }

  void registerNav() {
    _pages = [
      const HomePager(),
      const Favorites(),
      const Register(),
    ];

    notifyListeners();
  }

  void mypageNav() {
    _pages = [
      const HomePager(),
      const Favorites(),
      const Mypage(),
    ];

    notifyListeners();
  }

  /// Get the current active page
  Widget getActivePage() => _pages[_currentIndex];

  /// Getter for _pages
  List<Widget> get pages => _pages;

  /// Getter for _currentPageIndex
  int get currentIndex => _currentIndex;

  /// Setter for _currentPageIndex
  set currentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }
}
