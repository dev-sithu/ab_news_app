import 'package:ab_news_app/providers/favorite_provider.dart';
import 'package:ab_news_app/widgets/article.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final providerFavorite = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: titleBar(context, 'My Favorites'),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'You have ${providerFavorite.favorites.length} favorites:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (var article in providerFavorite.favorites)
            ArticleWidget(article: article)
        ],
      ),
    );
  }
}
