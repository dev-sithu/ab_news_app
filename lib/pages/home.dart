import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/services/news_api_service.dart';
import 'package:ab_news_app/widgets/article.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  getData(BuildContext ctx) {
    final providerArticle = Provider.of<ArticleProvider>(ctx);
    final api = getIt<NewsApiService>();

    return api.getNewStories().then((value) => providerArticle.articles = value); // update articles state
  }

  FutureBuilder getFutureBuilderWidget(BuildContext context) {
    return FutureBuilder(
      // Future that needs to be resolved
      // in order to display something on the Canvas
      future: getData(context),
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

  ListView getListViewWidget(BuildContext context, List items) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ArticleWidget(article: items[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerArticle = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: titleBar(context, 'AB News'),
      body: providerArticle.articles.isEmpty
        ? getFutureBuilderWidget(context) // data from the remote source or db
        : getListViewWidget(context, providerArticle.articles), // data from state
    );
  }
}
