import 'package:ab_news_app/config/constants.dart';
import 'package:ab_news_app/models/news_model.dart';
import 'package:dio/dio.dart';

class NewsApiService {
  final dio = Dio();

  // Get recent news
  Future<List<dynamic>> getTopStories() async {
    final response = await dio.get('$newsAPIBaseURL/topstories.json');
    final topNews = response.data.sublist(0, 20);
    List<Object> newsList = [];

    for (var id in topNews) {
      var news = await getStory(id);
      newsList.add(NewsModel.fromJson(news));
    }

    return Future.value(newsList);
  }

  /// Get news details
  Future<Map<String, dynamic>> getStory(int id) async {
    final response = await dio.get('$newsAPIBaseURL/item/$id.json');

    return response.data;
  }
}
