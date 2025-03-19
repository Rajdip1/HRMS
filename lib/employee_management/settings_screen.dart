import 'package:flutter/material.dart';

import '../authentication screens/sign_in_screen.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text("Log out", style: TextStyle(color: Colors.black)),
            onTap: () async {
              await AuthServiceMethods().SignOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}
