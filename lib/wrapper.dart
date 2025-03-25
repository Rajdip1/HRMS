import 'package:HRMS/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HRMS/authentication screens/sign_in_screen.dart';
import 'package:HRMS/employee_management/employee_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  bool isCheck = true; //trakcs while fetching user data

  @override
  void initState() {
    super.initState();
    checkLoginUser();
  }

  Future<void> checkLoginUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      //means User is logged in, and fetch role from firestore db
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if(userDoc.exists) {
        String role = userDoc["role"];

        if(role == 'HR') {
          navigateToScreen(DashboardScreen());
        } else {
          navigateToScreen(EmployeeHomeScreen());
        }
      }
      else {
        //role not found, log out user
        await FirebaseAuth.instance.signOut();
        navigateToScreen(SignInScreen());
      }
    }
    else {
      //user is not logged in
      navigateToScreen(SignInScreen());
    }
  }

  void navigateToScreen(Widget screen) {
    Future.microtask(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: isCheck ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Fetching role',style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500),),
              SizedBox(height: 16.0,),
              CircularProgressIndicator()
            ],
          ),
        ):SizedBox.shrink()
      )
    );
  }
}
