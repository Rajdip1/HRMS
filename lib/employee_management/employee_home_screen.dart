import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HRMS/authentication%20screens/sign_in_screen.dart';
import 'package:HRMS/employee_management/apply_leave_screen.dart';
import 'package:HRMS/employee_management/employee_edit_details_form.dart';
import 'package:HRMS/screens/attendance_screen.dart';
import 'package:HRMS/screens/settings_screen.dart';
import 'package:HRMS/services/auth_service.dart';
import 'package:HRMS/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
  final String? id = FirebaseAuth.instance.currentUser?.uid;
  Stream<DocumentSnapshot>? employeeStream;

  @override
  void initState() {
    super.initState();
    if (id != null) {
      employeeStream = DatabaseMethods().getEmployeeDetails(id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          'Employee Home',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      drawer: _widgetDrawer(context, isDarkMode),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Center(
          child: Column(
            children: [
              Text(
                'Welcome to HRMS',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              employeeDetails(isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget employeeDetails(bool isDarkMode) {
    return StreamBuilder<DocumentSnapshot>(
      stream: employeeStream,
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
          return const Center(child: Text('No data found'));
        }

        var employeeData = snapshot.data!.data() as Map<String, dynamic>;

        return Card(
          color: isDarkMode ? Colors.grey[700] : Colors.white,
          elevation: 10,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _employeeDetailText('Name', employeeData['Name'], isDarkMode),
                _employeeDetailText('Email', employeeData['Email'], isDarkMode),
                _employeeDetailText('Role', 'Employee', isDarkMode),
                _employeeDetailText('Department', employeeData['Department'], isDarkMode),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _employeeDetailText(String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _widgetDrawer(BuildContext context, bool isDarkMode) {
    return Drawer(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: isDarkMode ? Colors.black : Colors.blue),
            child: Row(
              children: [
                Image.asset(
                  'assets/illustration.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(width: 10),
                Text(
                  'HRMS',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(Icons.person, 'Edit Profile', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmployeeEditDetailsForm(empId: '')),
            );
          }, isDarkMode),
          _drawerItem(Icons.schedule, 'Attendance', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AttendanceScreen()),
            );
          }, isDarkMode),
          _drawerItem(Icons.time_to_leave, 'Apply Leave', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApplyLeaveScreen()),
            );
          }, isDarkMode),
          _drawerItem(Icons.settings, 'Settings', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          }, isDarkMode),
          _drawerItem(Icons.logout, 'Log out', () async {
            await AuthServiceMethods().SignOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          }, isDarkMode),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, bool isDarkMode) {
    return ListTile(
      leading: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      ),
      tileColor: isDarkMode ? Colors.black : Colors.white,
      onTap: onTap,
    );
  }
}
