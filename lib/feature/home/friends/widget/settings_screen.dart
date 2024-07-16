import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.grey[400],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, top: 15),
        child: ElevatedButton(
          onPressed: () {},
          child: const SizedBox(
            width: 80,
            height: 60,
          ),
        ),
      ),
    );
  }
}
