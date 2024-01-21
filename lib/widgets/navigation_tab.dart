import 'package:ab_news_app/pages/favorites.dart';
import 'package:ab_news_app/pages/home.dart';
import 'package:ab_news_app/pages/login.dart';
import 'package:ab_news_app/pages/mypage.dart';
import 'package:ab_news_app/pages/register.dart';
import 'package:flutter/material.dart';

class NavigationTab extends StatefulWidget {
  const NavigationTab({super.key});

  @override
  State<NavigationTab> createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  bool auth = false;
  int currentPageIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    // TODO: auth to check if user is logged-in or not
    if (auth) {
      pages = [
        const Home(),
        const Favorites(),
        const Mypage(),
      ];
    } else {
      pages = [
        const Home(),
        const Favorites(),
        Register({'login': goToLogin}),
      ];
    }

    super.initState();
  }

  void goToLogin() {
    setState(() {
      pages = [
        const Home(),
        const Favorites(),
        Login({
          'register': goToRegister,
          'mypage': goToMypage
        }),
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
            label: auth ? 'My page' : 'Register/Login',
          ),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
