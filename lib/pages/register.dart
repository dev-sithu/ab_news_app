import 'package:ab_news_app/database/database.dart';
import 'package:ab_news_app/extensions/string_validation.dart';
import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/nav_provider.dart';
import 'package:ab_news_app/services/auth/auth_service.dart';
import 'package:ab_news_app/services/user_service.dart';
import 'package:ab_news_app/utils/button_style.dart';
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
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String? userError; // User error message in state

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

  /// Async process to check if username exists in db
  Future<bool> checkUsernameExist()  async {
    setState(() {
      // clear any existing errors
      userError = null;
    });

    bool result = false;
    final user = await getIt<UserService>().findByUsername(_username.text);
    if (user != null) {
      result = true;
      setState(() {
        userError = 'The username is already in use. Try another one.';
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerNav = Provider.of<NavProvider>(context);

    return Scaffold(
      appBar: titleBar(context, 'Sign Up'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _username,
                enableSuggestions: false,
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Enter your login username here',
                  errorText: userError, // This would be updated by checkUsernameExist()
                ),
                validator: (value) { // The validator receives the text that the user has entered.
                  if (value == null || value.isEmpty) {
                    return 'Username is required.';
                  }

                  if (!value.isValidUsername) {
                    return 'Username can only contains letters, digits, periods, hypens and underscores.';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required.';
                  }

                  if (value.length < 6) {
                      return 'Your password is too short';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _rePassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Re-type the password here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Re-type the password.';
                  }

                  if (value != _password.text) {
                    return 'Password does not match.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                style: getPrimaryButtonStyle(),
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  final exists = await checkUsernameExist();
                  if (!exists) {
                    // Register user
                    User user = await getIt<UserService>().create(_username.text, _password.text);
                    debugPrint(user.toString());

                    // Login
                    await getIt<AuthService>().authenticate(user);
                    // notify user have logged-in
                    providerAuth.checkAuthentication();

                    if (!context.mounted) return;
                    showSnackBar(context, 'User registration is successful.');
                  }
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
      ),
    );
  }
}
