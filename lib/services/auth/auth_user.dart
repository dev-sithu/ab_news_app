import 'package:ab_news_app/database/database.dart';
import 'package:flutter/material.dart';

@immutable
class AuthUser {
  final int id;
  final String username;
  final int timestamp;

  const AuthUser({
    required this.id,
    required this.username,
    required this.timestamp
  });

  /// Convert json data to AuthUser object or return an empty object
  factory AuthUser.create(Map<String, dynamic>? data) {
    if (data != null) {
      return AuthUser(
        id: data['id'],
        username: data['username'],
        timestamp: data['timestamp'],
      );
    }

    return AuthUser(
      id: 0,
      username: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Convert user entity to json
  static Map<String, dynamic> toJson(User user) => {
    'id': user.id,
    'username': user.username,
    'timestamp': DateTime.now().millisecondsSinceEpoch
  };
}
