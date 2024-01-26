import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/services/news_api_service.dart';
import 'package:ab_news_app/widgets/article.dart';
import 'package:flutter/material.dart';

class ArticleListView extends StatefulWidget {
  final ArticleProvider provider;

  const ArticleListView({super.key, required this.provider});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {

  Future<List<Article>> _getData() async {
    final api = getIt<NewsApiService>();

    if (widget.provider.cachedArticles.isNotEmpty) {
      debugPrint('load data from state');
      return widget.provider.cachedArticles;
    }

    debugPrint('reload data from remote');
    widget.provider.articles = await api.getNewStories(); // Update articles in state

    final articlesByPage = await api.getStoryDetails(widget.provider.articles[0]); // return the first page only
    widget.provider.cachedArticles = articlesByPage;

    return articlesByPage;
  }

  Future<List<Article>> _refresh() {
    widget.provider.articles = []; // notify reload
    widget.provider.cachedArticles = [];

    return _getData();
  }

  RefreshIndicator getListViewWidget(BuildContext context, List items) {
    return RefreshIndicator(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ArticleWidget(article: items[index]);
        },
      ),
      onRefresh: () => _refresh(), // Reload data on pull down
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Future that needs to be resolved
      // in order to display something on the Canvas
      future: _getData(),
      builder: (ctx, snapshot) {
        // Checking if future is resolved or not
        if (snapshot.connectionState == ConnectionState.done) {
          // If we got an error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          // if we got our data
          if (snapshot.hasData) {
            // Extracting data from snapshot object
            final items = snapshot.data as List;

            return getListViewWidget(context, items);
          }
        }

        // Displaying LoadingSpinner to indicate waiting state
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
