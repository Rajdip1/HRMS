import 'package:demo/authentication%20screens/sign_up_screen.dart';
import 'package:demo/screens/dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:demo/splash_screen.dart';

import 'authentication screens/sign_in_screen.dart';
import 'employee_management/employee_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
      home:  SplashScreen(),
    );
  }
}
