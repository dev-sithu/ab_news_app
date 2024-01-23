import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({super.key});

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerNav = Provider.of<NavProvider>(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          providerNav.currentIndex = index; // Change tab
        },
        indicatorColor: Colors.amber,
        selectedIndex: providerNav.currentIndex,
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
      body: providerNav.getActivePage(),
    );
  }
}
