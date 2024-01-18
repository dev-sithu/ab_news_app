import 'package:ab_news_app/config/constants.dart';
import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/models/article_model.dart';
import 'package:ab_news_app/services/article_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService(this.dio);

  // Get recent news
  Future<List<dynamic>> getNewStories() async {
    final response = await dio.get('$newsAPIBaseURL/newstories.json');
    final topNews = response.data.sublist(0, 3);
    List<Object> newsList = [];
    ArticleService articleService = getIt<ArticleService>();

    for (var id in topNews) {
      debugPrint('trying to get local story ...');
      Article ? item = await articleService.findByItem(id);

      Map<String, dynamic> news;
      if (item != null) {
        // if there is related article in db
        debugPrint('item_id=${item.itemId} returned from db');
        news = item.toJson();
      } else {
        // no article in local db
        debugPrint('getting remote story...');
        news = await getStory(id);

        debugPrint('inserting into db');
        Article inserted = await articleService.create({
          'type': news['type'],
          'itemId': news['id'],
          'author': news['by'],
          'title': news['title'],
          'url': news['url'],
          'score': news['score'],
          'descendants': news['descendants'],
        });
        debugPrint(inserted.toString());
      }

      newsList.add(ArticleModel.fromJson(news));
    }

    return Future.value(newsList);
  }

  /// Get news details
  Future<Map<String, dynamic>> getStory(int id) async {
    final response = await dio.get('$newsAPIBaseURL/item/$id.json');

    return response.data;
  }
}
