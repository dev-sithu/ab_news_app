import 'dart:convert';

import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/auth/auth_user.dart';
import 'package:ab_news_app/services/storage_service.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';

class AuthService {
  final UserService userService;
  final StorageService storage;

  AuthService(this.userService, this.storage);

  /// Perform user authentication
  Future<Object> login(String username, password) async {
    User? user = await getIt<UserService>().findByUsername(username);
    if (user == null) {
      return 'Username does not exist.';
    }

    debugPrint('Verifying password...');
    if (!Password.verify(password, user.password)) {
      return 'Password does not match.';
    }

    await authenticate(user);

    return user;
  }

  /// Remove local storage for user session
  Future<void> logout() async {
    await storage.remove('auth');
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
       return AuthUser.fromJson(json.decode(auth));
    }

    return AuthUser.getSkeleton();
  }
}
