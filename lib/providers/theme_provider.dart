import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    saveTheme();
    notifyListeners();
  }

  void loadTheme() async {
    final preference = await SharedPreferences.getInstance();
    final isDarkMode = preference.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void saveTheme() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }

}