import 'package:ab_news_app/database/database.dart';

class FavoriteService {
  final AppDatabase db;

  FavoriteService(this.db);

  // Insert a favorite (if not exists)
  Future<Favorite> create(int userId, int newsId) async {
    final favorite = await checkExists(userId, newsId);
    if (favorite != null) {
      return favorite;
    }

    return await db.into(db.favorites).insertReturning(FavoritesCompanion.insert(
      userId: userId,
      newsId: newsId,
    ));
  }

  /// Find a favorite by user_id and news_id
  Future<Favorite?> checkExists(int userId, int newsId) async {
    final query = db.select(db.favorites)
      ..where((t) => t.userId.equals(userId))
      ..where((t) => t.newsId.equals(newsId))
      ..limit(1);

    return query.getSingleOrNull();
  }

  /// Find a favorite by id
  Future<Favorite?> find(int id) async {
    final query = db.select(db.favorites)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    return query.getSingleOrNull();
  }

  /// Get all favorites by user id
  Future<List<Favorite>> findByUser(int userId) async {
    return await (db.select(db.favorites)..where((t) => t.userId.equals(userId))).get();
  }
}
