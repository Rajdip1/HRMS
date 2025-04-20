import 'package:HRMS/attendance/scanned_list_page.dart';
import 'package:HRMS/attendance/todayscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HRMS/authentication screens/sign_in_screen.dart';
import 'package:HRMS/employee_management/employee_edit_details_form.dart';
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
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ).createShader(bounds),
          child: Text(
            'Employee Home',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: _widgetDrawer(context, isDarkMode),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Welcome to HRMS',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              employeeDetails(isDarkMode),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade900], // Gradient from light blue to dark blue
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Project Management",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black), // Changed text color to black
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade900], // Blue gradient for the image container
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/graph.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700], // Gradient from light to darker blue
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Task Details", textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black), // Changed text color to black
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStatusIndicator("Pending", Colors.pinkAccent, 1),
                              SizedBox(width: 10),
                              _buildStatusIndicator("On Hold", Colors.lightBlueAccent, 2),
                              SizedBox(width: 10),
                              _buildStatusIndicator("In Progress", Colors.blue, 3),
                              SizedBox(width: 10),
                              _buildStatusIndicator("Completed", Colors.pinkAccent, 4),
                              SizedBox(width: 10),
                              _buildStatusIndicator("Cancelled", Colors.lightBlueAccent, 2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
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

        var employeeData = snapshot.data!.data() as Map<String, dynamic>? ?? {};

        return Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
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
                  _employeeDetailText('Employment Type', employeeData['Employment Type'], isDarkMode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _employeeDetailText(String label, String ? value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label: ${value ?? 'Not available'}',
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
            decoration: BoxDecoration(color: isDarkMode ? Colors.blue : Colors.blue),
            child: Row(
              children: [
                Image.asset(
                  'assets/illustration.png',
                  height: 150,
                  width: 150,
                ),
                const SizedBox(width: 10),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.white, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'HRMS',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Ensures gradient visibility
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Drawer items
          _drawerItem(Icons.person, 'Edit Profile', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EmployeeEditDetailsForm(empId: '')),
            );
          }, isDarkMode),
          // _drawerItem(Icons.person, 'Attendance', () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => ScannerPage()),
          //   );
          // }, isDarkMode),
          // _drawerItem(Icons.developer_board, 'Projects', () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectSectionScreen()));
          // }, isDarkMode),
          // _drawerItem(Icons.time_to_leave, 'Apply Leave', () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => ApplyLeaveScreen()),
          //   );
          // }, isDarkMode),
          // _drawerItem(Icons.notifications, 'Notification', () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => NotificationManagementScreen()),
          //   );
          // }, isDarkMode),
          _drawerItem(Icons.qr_code, 'QR Generator', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRGeneratorPage()),
            );
          }, isDarkMode),
          // _drawerItem(Icons.calendar_month_rounded, 'Attendance List', () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => ScannedListPage()),
          //   );
          // }, isDarkMode),
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
  Widget _buildGradientText(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.blue, Colors.purple], // Gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Required to make gradient visible
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, bool isDarkMode) {
    return ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: _buildGradientText(title),
        tileColor: isDarkMode ? Colors.black : Colors.white,
        onTap: onTap,
    );
  }

  Widget _buildStatusIndicator(String status, Color color, int count) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text("$status ($count)", style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }

}