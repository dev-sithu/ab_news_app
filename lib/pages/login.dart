import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';

class Login extends StatefulWidget {
  final dynamic goToRegister;
  const Login(this.goToRegister, {super.key});

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

                User? user = await getIt<UserService>().findByUsername(username);
                if (user == null) {
                  debugPrint('Username does not exist.');
                  return;
                }

                debugPrint('Verifying password...');
                if (!Password.verify(password, user.password)) {
                  debugPrint('Password does not match.');
                  return;
                }

                // TODO: Login logic
                debugPrint('proceed to login...');
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: widget.goToRegister,
              child: const Text('Not registered yet? sign up here')
            )
          ],
        ),
      ),
    );
  }
}
