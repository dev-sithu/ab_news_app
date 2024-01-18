import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/services/article_service.dart';
import 'package:ab_news_app/services/news_api_service.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));

  getIt.registerSingleton<UserService>(UserService(getIt()));
  getIt.registerSingleton<ArticleService>(ArticleService(getIt()));
}
