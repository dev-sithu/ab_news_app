import 'package:ab_news_app/config/constants.dart';
import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/services/news_api_service.dart';
import 'package:ab_news_app/widgets/article.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagedArticleListView extends StatefulWidget {
  final ArticleProvider provider;

  const PagedArticleListView({super.key, required this.provider});

  @override
  State<PagedArticleListView> createState() => _PagedArticleListViewState();
}

class _PagedArticleListViewState extends State<PagedArticleListView> {
  List data = [];

  /// Instantiate a PagingController.

  // 1. When instantiating a PagingController, you need to specify two generic types. In your code
  // int: This is the type your endpoint uses to identify pages.
  // Article: This is the type that models your list items.
  final _pagingController = PagingController<int, Article>(
    // 2
    firstPageKey: 0,
  );

  @override
  void initState() {
    // 3. This is how you register a callback to listen for new page requests.
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    // 4. Don’t forget to dispose() your controller.
    _pagingController.dispose();
    super.dispose();
  }

  /// Prepare page for pagingController
  Future<void> _fetchPage(int pageKey) async {
    try {
      if (pageKey == 0 && widget.provider.articles.isNotEmpty) {
        widget.provider.articles = []; // notify reload
        widget.provider.cachedArticles = [];
      }

      final newItems = await _getData(pageKey);
      final isLastPage = newItems.length < pagerLimit;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  /// Get remote data or data from state
  Future<List<Article>> _getData(int pageKey) async {
    final api = getIt<NewsApiService>();

    if (widget.provider.articles.isEmpty) {
      debugPrint('reload data from remote');
      widget.provider.articles = await api.getNewStories(); // Update articles in state
    }

    final articlesByPage = await api.getStoryDetails(widget.provider.articles[pageKey]); // return the specific page only
    widget.provider.cachedArticles = [...articlesByPage];

    return articlesByPage;
  }

  @override
  Widget build(BuildContext context) =>
    // 1.
    // Wrapping scrollable widgets with Flutter’s RefreshIndicator empowers a feature known as swipe to refresh. T
    // The user can use this to refresh the list by pulling it down from the top.
    RefreshIndicator(
      onRefresh: () => Future.sync(
        // 2
        // PagingController defines refresh(), a function for refreshing its data.
        // You’re wrapping the refresh() call in a Future, because that’s how the onRefresh parameter from the RefreshIndicator expects it.
        () => _pagingController.refresh(),
      ),
      // 3
      // PagedListView has an alternative separated() constructor for adding separators between your list items.
      child: PagedListView.separated(
        // 4
        // You’re connecting your pieces.
        pagingController: _pagingController,
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        builderDelegate: PagedChildBuilderDelegate<Article>(
          itemBuilder: (context, item, index) => ArticleWidget(
            article: item,
          ),
        ),
      ),
    );
}
