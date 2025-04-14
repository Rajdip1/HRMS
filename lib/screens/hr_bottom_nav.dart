import 'package:HRMS/leave_management/leave_request_screen.dart';
import 'package:HRMS/screens/dashboard_screen.dart';
import 'package:HRMS/screens/employee_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../attendance/scanner_page.dart';
import '../providers/theme_provider.dart';

class HrBottomNav extends StatefulWidget {
  const HrBottomNav({super.key});

  @override
  State<HrBottomNav> createState() => _HrBottomNavState();
}

class _HrBottomNavState extends State<HrBottomNav> {
  int myIndex = 0;
  List<Widget> widgetList = [DashboardScreen(),ScannerPage(),LeaveRequestsScreen(),EmployeeManagementScreen()];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myIndex,
        backgroundColor: isDarkMode ? Colors.grey[700] : Colors.white,
        selectedItemColor: isDarkMode ? Colors.white : Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            activeIcon: Icon(Icons.qr_code_scanner),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.time_to_leave_outlined),
            activeIcon: Icon(Icons.time_to_leave_rounded),
            label: 'Leave Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people),
            label: 'Employees',
          ),
        ],
      ),

      body: Center(
        child: widgetList[myIndex],
      ),
    );
  }
}
