import 'package:HRMS/attendance/scanner_page.dart';
import 'package:HRMS/employee_management/apply_leave_screen.dart';
import 'package:HRMS/employee_management/employee_home_screen.dart';
import 'package:HRMS/employee_management/notification_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int myIndex = 0;
  List<Widget> widgetList = [EmployeeHomeScreen(),ScannerPage(),ApplyLeaveScreen(),NotificationManagementScreen()];

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
            label: 'Apply Leave',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            activeIcon: Icon(Icons.notifications_active),
            label: 'Notifications',
          ),
        ],
      ),

      body: Center(
        child: widgetList[myIndex],
      ),
    );
  }
}
