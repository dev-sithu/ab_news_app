import 'package:ab_news_app/inject_container.dart';
import 'package:ab_news_app/providers/auth_provider.dart';
import 'package:ab_news_app/providers/nav_provider.dart';
import 'package:ab_news_app/services/auth/auth_service.dart';
import 'package:ab_news_app/utils/button_style.dart';
import 'package:ab_news_app/utils/toasts.dart';
import 'package:ab_news_app/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _username;
  late final TextEditingController _password;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String? userError; // User error message in state
  String? pwdError; // Passwor error message in state

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

  /// Async process to check user validation with db
  Future<int> checkUserExist()  async {
    setState(() {
      // clear any existing errors
      userError = null;
      pwdError = null;
    });

    final result = await getIt<AuthService>().validateUser(_username.text, _password.text);
    if (result > 0) {
      setState(() {
        if (result == 1) userError = AuthService.getError(result);
        if (result == 2) pwdError = AuthService.getError(result);
      });
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<AuthProvider>(context);
    final providerNav = Provider.of<NavProvider>(context);

    return Scaffold(
      appBar: titleBar(context, 'Sign In'),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
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
                  errorText: userError, // This would be updated by checkUserExist()
                ),
                validator: (value) { // The validator receives the text that the user has entered.
                  return value == null || value.isEmpty ? 'Username is required.' : null;
                },
              ),
              TextFormField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Enter your password here',
                  errorText: pwdError, // This would be updated by checkUserExist()
                ),
                validator: (value) { // The validator receives the text that the user has entered.
                  return value == null || value.isEmpty ? 'Password is required.' : null;
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

                  int result = await checkUserExist();

                  if (AuthService.getError(result) == null) { // if no error
                    final user = await getIt<AuthService>().login(_username.text, _password.text);
                    String msg = '';
                    if (user != null) {
                      providerAuth.checkAuthentication(); // notify user have logged-in
                      msg = 'Login successful.';
                    } else {
                      msg = 'Login failed.';
                    }

                    if (!context.mounted) return;
                    showSnackBar(context, msg);
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => providerNav.registerNav(),
                child: const Text('Not registered yet? sign up here')
              )
            ],
          ),
        ),
      ),
    );
  }
}
