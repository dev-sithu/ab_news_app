import 'package:drift/drift.dart';

// Tables can mix-in common definitions if needed
mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

// users table
@DataClassName('User')
class Users extends Table with AutoIncrementingPrimaryKey {
  TextColumn get username => text().withLength(max: 100)();
  TextColumn get password => text().withLength(max: 255)();
}

// favorites table
@DataClassName('Favorite')
class Favorites extends Table with AutoIncrementingPrimaryKey {
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get newsId => integer()();
}

// articles (news) table
@DataClassName('Article')
class Articles extends Table with AutoIncrementingPrimaryKey {
  IntColumn get itemId      => integer()(); // item id from API
  TextColumn get type       => text().withLength(max: 20)();
  TextColumn get title      => text().withLength(max: 500)();
  TextColumn get author     => text().withLength(max: 255).nullable()();
  TextColumn get url        => text().withLength(max: 500).nullable()();
  IntColumn get score       => integer().nullable()();
  IntColumn get time        => integer().nullable()();
  IntColumn get descendants => integer().nullable()();
}
