import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/nav_provider.dart';
import 'package:ab_news_app/services/auth/auth_service.dart';
import 'package:ab_news_app/utils/button_style.dart';
import 'package:ab_news_app/utils/toasts.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerNav = Provider.of<NavProvider>(context);
    final username = providerAuth.user.username;

    return Scaffold(
      appBar: titleBar(context, 'My Page'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Username'),
            Text(
              username,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20.0),
            TextButton(
              style: getPrimaryButtonStyle(),
              onPressed: () async {
                await getIt<AuthService>().logout();
                providerAuth.checkAuthentication();  // notify user have signed out
                providerNav.currentIndex = 0; // Change the default tab

                if (!context.mounted) return;
                showSnackBar(context, 'Logout successful.');
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
