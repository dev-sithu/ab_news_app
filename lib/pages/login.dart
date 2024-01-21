import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/auth_service.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Map<String, dynamic> navigation;
  const Login(this.navigation, {super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _username;
  late final TextEditingController _password;

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();

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
    return Scaffold(
      appBar: titleBar(context, 'Sign In'),
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
            const SizedBox(height: 10),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.all(20.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                final username = _username.text;
                final password = _password.text;

                // Validation
                if (username.isEmpty) {
                  debugPrint('Username is required.');
                  return;
                }

                if (password.isEmpty) {
                  debugPrint('Password is required.');
                  return;
                }

                final result = await getIt<AuthService>().login(username, password);
                if (result is String) {
                  debugPrint(result);
                  return;
                }

                widget.navigation['mypage']();
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: widget.navigation['register'],
              child: const Text('Not registered yet? sign up here')
            )
          ],
        ),
      ),
    );
  }
}
