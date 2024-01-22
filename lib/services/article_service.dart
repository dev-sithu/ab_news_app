import 'dart:async';

import 'package:ab_news_app/database/database.dart';
import 'package:drift/drift.dart';

class ArticleService {
  final AppDatabase db;

  ArticleService(this.db);

  /// Map json from API to table fields
  static Map<String, dynamic> fieldMapper(Map<String, dynamic> data) {
    return {
      'itemId': data['id'],
      'type': data['type'],
      'author': data['by'],
      'title': data['title'],
      'url': data['url'] ?? '',
      'score': data['score'],
      'time': data['time'],
      'descendants': data['descendants'],
    };
  }

  /// Insert a news article
  Future<Article> create(Map<String, dynamic> data) async {
    return await db.into(db.articles).insertReturning(ArticlesCompanion.insert(
        itemId: data['itemId'],
        type: data['type'],
        title: data['title'],
        author: Value(data['author'] ?? Null),
        url: Value(data['url'] ?? Null),
        score: Value(data['score'] ?? Null),
        time: Value(data['time'] ?? Null),
        descendants: Value(data['descendants'] ?? Null),
    ));
  }

  /// Find a news article by id
  Future<Article?> find(int id) async {
    final query = db.select(db.articles)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    return query.getSingleOrNull();
  }

  /// Find a news article by item_id
  Future<Article?> findByItem(int itemId) async {
    final query = db.select(db.articles)
      ..where((t) => t.itemId.equals(itemId))
      ..limit(1);

    return query.getSingleOrNull();
  }

   /// Get all news article
  Future<List<Article>> findAll() async {
    return await db.select(db.articles).get();
  }
}
