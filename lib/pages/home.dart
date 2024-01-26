import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/widgets/article_list_view.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Home page without infinite scroll pagination
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar(context, 'AB News'),
      body: ArticleListView(
        provider: Provider.of<ArticleProvider>(context)
      )
    );
  }
}
