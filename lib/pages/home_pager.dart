import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/widgets/paged_article_list_view.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Home page with infinite scroll pagination
class HomePager extends StatelessWidget {
  const HomePager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleBar(context, 'AB News'),
      body: PagedArticleListView(
        provider: Provider.of<ArticleProvider>(context)
      )
    );
  }
}
