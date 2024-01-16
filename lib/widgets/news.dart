import 'package:ab_news_app/models/news_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsWidget extends StatelessWidget {
  final NewsModel news;

  const NewsWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
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
                  text: news.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                const WidgetSpan(child: SizedBox(width: 10)),
                TextSpan(
                  text: news.url,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    final url = Uri.parse(news.url ?? '');

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
                news.author != null ? 'by ${news.author}' : '',
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => {
                  // TODO: favorite logic (to db)
                  print('Favorited!')
                },
                icon: const Icon(Icons.favorite_border),
                label: const Text('Favorite'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
