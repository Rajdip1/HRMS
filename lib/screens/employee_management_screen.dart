import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/database.dart';
import 'edit_profile.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  TextEditingController searchController = TextEditingController();
  String? id = FirebaseAuth.instance.currentUser?.uid;
  Stream<QuerySnapshot>? employeeStream;

  @override
  void initState() {
    super.initState();
    employeeStream = DatabaseMethods().getAllEmployeeDetails();
  }

  // Delete Employee
  deleteData(String empId) async {
    await DatabaseMethods().deleteEmployeeDetails(empId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('All Employee List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Widget allEmployeeDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: employeeStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No employees found"));
        }

        var users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index].data() as Map<String, dynamic>;
            String empId = users[index].id; // Get Firestore document ID

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(user["Name"] ?? "No Name"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${user["email"] ?? "No Email"}"),
                    Text("Role: ${user["role"] ?? "No Role"}"),
                    Text("Department: ${user["Department"] ?? "Not Assigned"}"),
                  ],
                ),
                leading: Icon(Icons.person),
                trailing: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit_profile') {
                      // Navigate with selected employeeId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeeEditDetailsForm(empId: empId),
                        ),
                      );
                    } else if (value == 'delete') {
                      deleteData(empId); // Delete using Firestore doc ID
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'edit_profile', child: Text('Edit Profile')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
