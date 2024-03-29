import 'package:ab_news_app/config/app_theme.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/article_provider.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/favorite_provider.dart';
import 'package:ab_news_app/providers/nav_provider.dart';
import 'package:ab_news_app/widgets/navigation_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, FavoriteProvider>(
          update: (context, auth, fav) => FavoriteProvider(auth),
          create: (BuildContext context) => FavoriteProvider(null),
        ),
        ChangeNotifierProxyProvider<AuthProvider, NavProvider>(
          update: (context, auth, nav) => NavProvider(auth),
          create: (BuildContext context) => NavProvider(null),
        ),
        ChangeNotifierProvider(create: (context) => ArticleProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const NavigationTab(),
      ),
    );
  }
}
