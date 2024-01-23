import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/auth/auth_service.dart';
import 'package:ab_news_app/services/auth/auth_user.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isUserLoggedIn = false;
  late AuthUser _user;

  /// Constructor
  AuthProvider() {
    checkAuthentication();
  }

  /// Check & change user state
  void checkAuthentication() async {
    _isUserLoggedIn = await getIt<AuthService>().ifAuthenticated();
    if (_isUserLoggedIn) {
      _user = await getIt<AuthService>().getUser();
    }

    notifyListeners();
  }

  /// Getter for _isUserLoggedIn
  bool get isUserLoggedIn => _isUserLoggedIn;

  /// Getter for _user
  AuthUser get user => _user;
}
