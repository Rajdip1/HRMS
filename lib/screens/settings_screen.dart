import 'package:demo/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Change app theme',style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Switch(value: themeProvider.themeMode==ThemeMode.dark, onChanged: (value) {
                      themeProvider.toggleTheme();
                    }),
                  ],
                ),
                // Text('Notification setting',style: TextStyle(fontSize: 20),),
              ],
            ),
          )
        ],
      )
    );
  }
}
