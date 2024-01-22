import 'package:ab_news_app/config/constants.dart';
import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/article_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService(this.dio);

  // Get recent news
  Future<List<Article>> getNewStories() async {
    final response = await dio.get('$newsAPIBaseURL/newstories.json');
    final recentNews = response.data.sublist(0, 15);
    List<Article> newsList = [];
    ArticleService articleService = getIt<ArticleService>();
    Map<String, dynamic> news;

    for (var id in recentNews) {
      debugPrint('trying to get local story ...');
      Article ? item = await articleService.findByItem(id);

      if (item != null) {
        // if there is related article in db
        debugPrint('item_id=${item.itemId} returned from db');
        newsList.add(item);
      } else {
        // no article in local db
        debugPrint('getting remote story...');
        news = await getStory(id);
        news = ArticleService.fieldMapper(news);

        debugPrint('inserting into db ${news.toString()}');
        Article inserted = await articleService.create(news);
        newsList.add(inserted);
      }
    }

    return Future.value(newsList);
  }

  /// Get news details
  Future<Map<String, dynamic>> getStory(int id) async {
    final response = await dio.get('$newsAPIBaseURL/item/$id.json');

    return response.data;
  }
}
