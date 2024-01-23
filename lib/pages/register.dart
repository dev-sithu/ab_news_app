import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/nav_provider.dart';
import 'package:ab_news_app/services/auth/auth_service.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:ab_news_app/utils/toasts.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _rePassword;

  @override
  void initState() {
    _username   = TextEditingController();
    _password   = TextEditingController();
    _rePassword = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerNav = Provider.of<NavProvider>(context);

    return Scaffold(
      appBar: titleBar(context, 'Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _username,
              enableSuggestions: false,
              autocorrect: false,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter your login username here',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password here',
              ),
            ),
            TextField(
              controller: _rePassword,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Re-type the password here',
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.all(20.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                final username    = _username.text;
                final password    = _password.text;
                final rePassword  = _rePassword.text;

                // Validation
                if (username.isEmpty) {
                  showSnackBar(context, 'Username is required.');
                  return;
                }

                if (password.isEmpty) {
                  showSnackBar(context, 'Password is required.');
                  return;
                }

                if (rePassword.isEmpty) {
                  showSnackBar(context, 'Re-type the password.');
                  return;
                }

                if (password != rePassword) {
                  showSnackBar(context, 'Password does not match.');
                  return;
                }

                final existingUser = await getIt<UserService>().findByUsername(username);
                if (existingUser != null) {
                  if (!context.mounted) return;
                  showSnackBar(context, 'The username is already in use. Try another one.');
                  return;
                }

                // Register user
                User user = await getIt<UserService>().create(username, password);
                debugPrint(user.toString());

                // Login
                await getIt<AuthService>().authenticate(user);
                // notify user have logged-in
                providerAuth.checkAuthentication();

                if (!context.mounted) return;
                showSnackBar(context, 'User registration is successful.');
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => providerNav.loginNav(),
              child: const Text('Already have an account? login here')
            )
          ],
        ),
      ),
    );
  }
}
