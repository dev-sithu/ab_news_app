import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/services/news_api_service.dart';
import 'package:ab_news_app/widgets/article.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Article> data = [];

  Future<List<Article>>getData(BuildContext ctx, bool refresh) {
    final providerArticle = ctx.read<ArticleProvider>();
    if (refresh) {
      providerArticle.articles = [];
      setState(() {
        data = [];
      });
    }

    if (providerArticle.articles.isEmpty) {
      debugPrint('refresh');
      final api = getIt<NewsApiService>();

      return api.getNewStories().then((value) {
        // update articles state
        providerArticle.articles = value;

        setState(() {
          data = value;
        });

        return value;
      });
    } else {
      debugPrint('data from state');
      return Future.value(providerArticle.articles);
    }
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
      onRefresh: () => getData(context, true), // Reload data on pull down
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar(context, 'AB News'),
      body: FutureBuilder(
        // Future that needs to be resolved
        // in order to display something on the Canvas
        future: getData(context, false),
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
      ),
    );
  }
}
