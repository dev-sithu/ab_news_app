import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/favorite_provider.dart';
import 'package:ab_news_app/services/favorite_service.dart';
import 'package:ab_news_app/utils/toasts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;

  const ArticleWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerFavorite = Provider.of<FavoriteProvider>(context);

    IconData icon;
    if (providerFavorite.favorites.contains(article)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Container(
      padding: const EdgeInsetsDirectional.all(10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffdedede), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: article.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(
                  text: article.url,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final url = Uri.parse(article.url ?? '');

                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                article.author != null ? 'by ${article.author}' : '',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  String msg = '';
                  if (providerAuth.isUserLoggedIn) {
                    final userId = providerAuth.user['id'];

                    msg = await getIt<FavoriteService>().toggleFavorite(userId, article.id); // toggle in db
                    providerFavorite.toggleFavorite(article); // toggle in state

                    if (!context.mounted) return;
                    showSnackBar(context, msg);
                  } else {
                    showSnackBar(context, 'You need to login first!');
                  }
                },
                icon: Icon(icon),
                label: const Text('Favorite'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
