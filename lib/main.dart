import 'package:ab_news_app/config/app_theme.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/auth_service.dart';
import 'package:ab_news_app/widgets/navigation_tab.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  // Testing user authentication
  final auth = await getIt<AuthService>().authenticated();
  debugPrint(auth ? 'logged-in' : 'anonymous');
  if (auth) {
    final userData = await getIt<AuthService>().getUser();
    debugPrint(userData.toString());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: const NavigationTab(),
    );
  }
}
