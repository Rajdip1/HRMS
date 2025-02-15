import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrms/dashBoards/admin.dart';
import 'package:hrms/screens/home.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Sign up
  Future signUpWithEmailAndPassword(String email, String password, String role, BuildContext context) async {
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(email: email, password: password);

      //store role during sign up
      await firestore.collection("users").doc(uc.user?.uid).set({
        'email': email,
        'role': role
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
    }
    catch (e) {
      print(e);
    }
  }

  //Log in
  Future logIn(String email, String password, Function(String) onSelectedRole) async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(email: email, password: password);

      //fetch user role from db
      DocumentSnapshot userDocs = await firestore.collection("users").doc(uc.user!.uid).get();
      String role = userDocs['role'];

      // Pass role back to the calling function
      onSelectedRole(role);

    }
    catch (e) {
      print(e);
    }
  }

  //Forgot password
  // Future forgotPassword(String email) async {
  //   try {
  //     await auth.sendPasswordResetEmail(email: email);
  //   }
  //   catch (e) {
  //     print(e);
  //   }
  // }
}