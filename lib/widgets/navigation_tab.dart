import 'package:ab_news_app/pages/favorites.dart';
import 'package:ab_news_app/pages/home.dart';
import 'package:ab_news_app/pages/login.dart';
import 'package:ab_news_app/pages/mypage.dart';
import 'package:ab_news_app/pages/register.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Register({'login': goToLogin}),
    ];

    super.initState();
  }

  void goToLogin() {
    setState(() {
      pages = [
        const Home(),
        const Favorites(),
        Login({'register': goToRegister}),
      ];
    });
  }

  void goToRegister() {
    setState(() {
      pages = [
        const Home(),
        const Favorites(),
        Register({'login': goToLogin}),
      ];
    });
  }

  void goToMypage() {
     setState(() {
      pages = [
        const Home(),
        const Favorites(),
        const Mypage(),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    if (providerAuth.isUserLoggedIn) {
      setState(() {
        pages = [
          const Home(),
          const Favorites(),
          const Mypage(),
        ];
      });
    }

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle_outlined),
            label: providerAuth.isUserLoggedIn ? 'My page' : 'Register/Login',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
