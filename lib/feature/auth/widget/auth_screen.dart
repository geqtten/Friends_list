import 'package:flutter/material.dart';
import 'package:friends_list/feature/auth/widget/auth_scope.dart';

import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Log in',
              style: TextStyle(color: Colors.black87, fontSize: 26),
            ),
            TextFormField(
              controller: _loginController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: "Login",
                filled: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Text(
              auth.error ?? '',
              style: const TextStyle(color: Colors.red),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login(context, auth);
                    },
                    child: const Text(
                      "Log in",
                    ),
                  ),
                  const SizedBox(
                    width: 110,
                    height: 140,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/signUp');
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context, AuthController auth) {
    auth.login(
      _loginController.text,
      _passwordController.text,
    );
    if (auth.error != null) {
      final snackBar = SnackBar(
        content: Text(
          AuthScope.of(context).error.toString(),
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
