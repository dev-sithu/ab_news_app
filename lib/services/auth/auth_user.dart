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

  /// Get an default empty object
  factory AuthUser.getSkeleton() => AuthUser(
    id: 0,
    username: '',
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  /// Convert json data to AuthUser object
  factory AuthUser.fromJson(Map<String, dynamic> data) => AuthUser(
    id: data['id'],
    username: data['username'],
    timestamp: data['timestamp'],
  );

  /// Convert user entity to json
  static Map<String, dynamic> toJson(User user) => {
    'id': user.id,
    'username': user.username,
    'timestamp': DateTime.now().millisecondsSinceEpoch
  };
}
