import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isUserLoggedIn = false;

  AuthProvider() {
    checkAuthentication();
  }

  void checkAuthentication() async {
    isUserLoggedIn = await getIt<AuthService>().authenticated();
    notifyListeners();
  }
}
