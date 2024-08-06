import 'package:flutter/material.dart';
import 'package:friends_list/feature/auth/widget/auth_scope.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = AuthScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                deleteAccount(context, auth);
              },
              child: const Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                logout(context, auth);
              },
              child: const Text('Sign out',
                  style: TextStyle(
                    fontSize: 25,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context, AuthController auth) {
    auth.logout();
    if (auth.error != null) {
      final snackBar = SnackBar(
        content: Text(
          AuthScope.of(context).error.toString(),
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void deleteAccount(BuildContext context, AuthController auth) {
    auth.deleteAccount(auth.loginUser!.id);
    if (auth.error != null) {
      final snackBar = SnackBar(
        content: Text(
          AuthScope.of(context).error.toString(),
        ),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
