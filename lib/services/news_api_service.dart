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
  Future<List<List<int>>> getNewStories() async {
    List<List<int>> newsIds = [];

    final response = await dio.get('$newsAPIBaseURL/newstories.json');
    List<int> data = List<int>.from(response.data);
    // Slice array of item id into pages
    var start = 0;
    while (start < data.length) {
      var end = start + pagerLimit;
      if (end > data.length) end = data.length;

      newsIds.add(data.sublist(start, end));
      start = start + pagerLimit;
    }

    return newsIds;
  }

  /// Get news details
  Future<Map<String, dynamic>> getStory(int id) async {
    final response = await dio.get('$newsAPIBaseURL/item/$id.json');

    return response.data;
  }

  Future<List<Article>> getStoryDetails(List<int> articles) async {
    List<Article> newsList = [];
    ArticleService articleService = getIt<ArticleService>();
    Map<String, dynamic> news;

    for (var id in articles) {
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

    return newsList;
  }
}
