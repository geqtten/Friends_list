import 'package:flutter/material.dart';
import 'package:friends_list/feature/auth/widget/auth_scope.dart';

import 'package:go_router/go_router.dart';

class AuthSignUp extends StatefulWidget {
  const AuthSignUp({
    super.key,
  });

  @override
  State<AuthSignUp> createState() => _AuthSignUpState();
}

class _AuthSignUpState extends State<AuthSignUp> {
  late TextEditingController _signUpLoginController;
  late TextEditingController _signUpPasswordController;
  @override
  void initState() {
    super.initState();
    _signUpLoginController = TextEditingController();
    _signUpPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _signUpLoginController.dispose();
    _signUpPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            (context).go("/");
          },
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(color: Colors.black87, fontSize: 26),
            ),
            TextFormField(
              controller: _signUpLoginController,
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
              controller: _signUpPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            // Text(
            //   auth.error ?? '',
            //   style: const TextStyle(color: Colors.red),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Row(
                children: [
                  const SizedBox(
                    width: 160,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signUp(context, auth);
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

  void signUp(BuildContext context, AuthController auth) {
    auth.signUp(
      _signUpLoginController.text,
      _signUpPasswordController.text,
    );
    if (auth.error != null) {
      final snackBar = SnackBar(
        content: Text(AuthScope.of(context).error.toString()),
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
