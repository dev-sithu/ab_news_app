import 'package:ab_news_app/pages/favorites.dart';
import 'package:ab_news_app/pages/home.dart';
import 'package:ab_news_app/pages/login.dart';
import 'package:ab_news_app/pages/register.dart';
import 'package:flutter/material.dart';

class NavigationTab extends StatefulWidget {
  const NavigationTab({super.key});

  @override
  State<NavigationTab> createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  int currentPageIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    pages = [
      const Home(),
      const Favorites(),
      Register(goToLogin),
    ];

    super.initState();
  }

  void goToLogin() {
    setState(() {
      pages = [
        const Home(),
        const Favorites(),
        Login(goToRegister),
      ];
    });
  }

  void goToRegister() {
    setState(() {
      pages = [
        const Home(),
        const Favorites(),
        Register(goToLogin),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Register/Login',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
