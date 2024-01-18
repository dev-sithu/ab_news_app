import 'dart:async';

import 'package:ab_news_app/database/database.dart';
import 'package:drift/drift.dart';

class ArticleService {
  final AppDatabase db;

  ArticleService(this.db);

  /// Insert a news article
  Future<Article> create(Map<String, dynamic> data) async {
    return await db.into(db.articles).insertReturning(ArticlesCompanion.insert(
        itemId: data['itemId'],
        type: data['type'],
        title: data['title'],
        author: Value(data['by'] ?? ''),
        url: Value(data['url'] ?? ''),
        score: Value(data['score'] ?? 0),
        descendants: Value(data['descendants'] ?? 0),
    ));
  }

  /// Find a news article by id
  Future<Article?> find(int id) async {
    return await (db.select(db.articles)..where((t) => t.id.equals(id)))
      .getSingleOrNull();
  }

  /// Find a news article by item_id
  Future<Article?> findByItem(int itemId) async {
    return await (db.select(db.articles)..where((t) => t.itemId.equals(itemId)))
      .getSingleOrNull();
  }

   /// Get all news article
  Future<List<Article>> findAll() async {
    return await db.select(db.articles).get();
  }
}
