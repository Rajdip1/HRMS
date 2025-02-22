import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrms/screens/employee_details.dart';
import 'package:hrms/services/database.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,

      appBar: AppBar(
        title: Text(
          'Admin Profile',
          style: TextStyle(
              color: Colors.blue, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            label: Text('Log out',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            icon: Icon(Icons.logout,size: 30,),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }


}
