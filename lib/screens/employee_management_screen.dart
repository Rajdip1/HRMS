import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/database.dart';
import 'edit_profile.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  String? id = FirebaseAuth.instance.currentUser?.uid;
  Stream<QuerySnapshot>? employeeStream;

  List<DocumentSnapshot> allUsers = [];
  List<DocumentSnapshot> filteredUsers = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    DatabaseMethods().getAllEmployeeDetails().listen((snapshot) {
      setState(() {
        allUsers = snapshot.docs;
        filteredUsers = allUsers;
      });
    });
  }


  // Delete Employee
  deleteData(String empId) async {
    await DatabaseMethods().deleteEmployeeDetails(empId);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Listen for theme changes
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.grey[900] : Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text('All Employee List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search employees',
                prefixIcon: Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )
              ),
              onChanged: (value) {
                searchQuery = value.toLowerCase();
                setState(() {
                  searchQuery = value.toLowerCase();
                  filteredUsers = allUsers.where((doc) {
                    var userData = doc.data() as Map<String, dynamic>;
                    var name = userData['Name']?.toLowerCase() ?? '';
                    return name.contains(searchQuery);
                  }).toList();
                });
              },
            ),
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Widget allEmployeeDetails() {
    if (filteredUsers.isEmpty) {
      return Center(child: Text("No matching employees"));
    }

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        var user = filteredUsers[index].data() as Map<String, dynamic>;
        String empId = filteredUsers[index].id;

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeEditDetailsForm(empId: empId),
                    ),
                  );
                } else if (value == 'delete') {
                  deleteData(empId);
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
  }
}
