import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _initializeTheme();
  }

  void toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _saveTheme();
    notifyListeners();
  }

  Future<void> _initializeTheme() async {
    await _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (_themeMode != (isDarkMode ? ThemeMode.dark : ThemeMode.light)) {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _themeMode == ThemeMode.dark);
  }
}
