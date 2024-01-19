import 'package:ab_news_app/database/database.dart';
import 'package:password_dart/password_dart.dart';

class UserService {
  final AppDatabase db;

  UserService(this.db);

  /// Insert a user
  Future<User> create(String username, String password) async {
    final pwd = Password.hash(password, PBKDF2());

    return await db.into(db.users).insertReturning(UsersCompanion.insert(
      username: username,
      password: pwd,
    ));
  }

  /// Find a user by id
  Future<User?> find(int id) async {
    final query = db.select(db.users)
      ..where((t) => t.id.equals(id))
      ..limit(1);

    return query.getSingleOrNull();
  }

  /// Find a user by username
  Future<User?> findByUsername(String username) async {
    final query = db.select(db.users)
        ..where((t) => t.username.equals(username))
        ..limit(1);

    return query.getSingleOrNull();
  }

  /// Get all users
  Future<List<User>> findAll() async {
    return await db.select(db.users).get();
  }
}
