import 'dart:convert';

import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/auth/auth_user.dart';
import 'package:ab_news_app/services/storage_service.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';

class AuthService {
  final UserService userService;
  final StorageService storage;

  AuthService(this.userService, this.storage);

  static String? getError(int errNo) {
    switch (errNo) {
      case 1:
        return 'Username does not exist.';
      case 2:
        return 'Password does not match.';
      default:
        return null;
    }
  }

  /// Perform user authentication
  Future<User?> login(String username, password) async {
    User? user = await getIt<UserService>().findByUsername(username);
    if (user != null) {
      await authenticate(user);
    } else {
      debugPrint(getError(1));
    }

    return user;
  }

  /// Remove local storage for user session
  Future<void> logout() async {
    await storage.remove('auth');
  }

  /// Check user exists by username and password
  /// and return an exact error no. if not exist
  Future<int> validateUser(String username, String password) async {
    User? user = await getIt<UserService>().findByUsername(username);
    if (user == null) {
      return 1;
    }

    debugPrint('Verifying password...');
    if (!DBCrypt().checkpw(password, user.password)) {
      return 2;
    }

    return 0;
  }

  /// Store user data in secure storage (alike Session)
  Future<void> authenticate(User user) async {
    final data = AuthUser.toJson(user);

    await storage.add('auth', json.encode(data));
  }

  /// Check if user already logged-in or not
  Future<bool> ifAuthenticated() async {
    final auth = await storage.read('auth');

    return auth != null;
  }

  /// Get user data from secure storage
  Future<AuthUser> getUser() async {
    final auth = await storage.read('auth');
    if (auth != null) {
       return AuthUser.create(json.decode(auth));
    }

    return AuthUser.create(null);
  }
}
