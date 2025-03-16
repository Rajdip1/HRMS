import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/MyUser.dart';

class AuthServiceMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //create user obj based on FirebaseUser
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid):null;
  }

  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // .map((User? user) => _userFromFirebaseUser(user!)!);
  }

  //sign up function
  Future register(String email, String password, String role) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      //store role during sign up
      await _firestore.collection("users").doc(uc.user?.uid).set({
        'email': email,
        'role': role
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Account is created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      });
    }
    catch (e) {
      print(e);
    }
  }

  //log in function
  Future<MyUser?> logIn(String email, String password, Function(String) navigateProfile) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? usr = result.user;

      if(usr==null) {
        Fluttertoast.showToast(msg: 'User not found',backgroundColor: Colors.red);
        return null;
      }

      //fetch user role from db
      DocumentSnapshot userDocs = await _firestore.collection("users").doc(usr.uid).get();

      if(userDocs.exists) {
        String role = userDocs['role'];
        navigateProfile(role);  //function called
        return _userFromFirebaseUser(usr);
      }
      else {
        Fluttertoast.showToast(msg: 'User role not found',backgroundColor: Colors.orange);
        return null;
      }

    }
    catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'Invalid credentials',backgroundColor: Colors.red);
      return null;
    }
  }

  //Log out
  Future<void> SignOut() async {
    try {
      await _auth.signOut();
      Fluttertoast.showToast(msg: 'Logged out',backgroundColor: Colors.red);
    }
    catch (e) {
      print('Logout error: $e');
      Fluttertoast.showToast(msg: 'Logged failed',backgroundColor: Colors.red);
    }
  }
}