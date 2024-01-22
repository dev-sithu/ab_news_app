import 'package:ab_news_app/database/database.dart';
import 'package:drift/drift.dart';

class FavoriteService {
  final AppDatabase db;

  FavoriteService(this.db);

  // Insert a favorite (if not exists)
  Future<Favorite> create(int userId, int newsId) async {
    return await db.into(db.favorites).insertReturning(FavoritesCompanion.insert(
      userId: userId,
      newsId: newsId,
    ));
  }

  // Delete a favorite
  Future<void> remove(Favorite fav) async {
    await db.favorites.deleteOne(fav);
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
  Future<List<Article>> findByUser(int userId) async {
    final query = db.favorites.select()
      .join([
        innerJoin(db.articles, db.articles.id.equalsExp(db.favorites.newsId))
      ])
      ..where(db.favorites.userId.equals(userId));

    return query.map((row) => row.readTable(db.articles)).get();
  }

  /// Add/Remove into/from favorites
  Future<String> toggleFavorite(int userId, int newsId) async {
    Favorite? fav = await checkExists(userId, newsId);
    String msg;

    if (fav == null) {
      // if not exist, insert into favorites
      fav = await create(userId, newsId);
      msg = 'Saved into favorites';
    } else {
      // if exists, remove from favorites
      await remove(fav);
      msg = 'Removed from favorites.';
    }

    return msg;
  }
}
