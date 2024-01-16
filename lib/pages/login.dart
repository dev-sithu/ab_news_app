import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';

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
            TextButton(
              onPressed: () async {
                final username = _username.text;
                final password = _password.text;

                print(username);
                print(password);

                // TODO: Login logic
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: widget.goToRegister,
              child: const Text('Not registered yet?, sign up here')
            )
          ],
        ),
      ),
    );
  }
}
