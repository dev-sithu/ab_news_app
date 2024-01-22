import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:ab_news_app/utils/toasts.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Map<String, dynamic> navigation;
  const Register(this.navigation, {super.key});

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

                // Register user
                var user = await getIt<UserService>().create(username, password);
                debugPrint(user.toString());

                if (!context.mounted) return;
                showSnackBar(context, 'User registration is successful.');
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: widget.navigation['login'],
              child: const Text('Already have an account? login here')
            )
          ],
        ),
      ),
    );
  }
}
