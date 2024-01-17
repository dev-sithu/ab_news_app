import 'package:ab_news_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';

class UserService {
  final AppDatabase db;

  UserService(this.db);

  // Insert a user
  Future<int> insertUser(String username, String password) async {
    final pwd = Password.hash('password', PBKDF2());

    return await db.into(db.users).insert(UsersCompanion.insert(
      username: username,
      password: pwd,
    ));
  }

  /// Get all users
  Future<List<User>> getUsers() async {
    List<User> users = await db.select(db.users).get();
    debugPrint('users in database: $users');

    return users;
  }
}
