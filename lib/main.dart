import 'package:ab_news_app/config/app_theme.dart';
// import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/widgets/navigation_tab.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final database = AppDatabase();

  // await database.into(database.users).insert(UsersCompanion.insert(
  //       username: 'admin',
  //       password: 'password',
  //     ));
  // List<User> allItems = await database.select(database.users).get();

  // print('items in database: $allItems');

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
