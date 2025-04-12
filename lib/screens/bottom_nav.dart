import 'package:HRMS/attendance/scanner_page.dart';
import 'package:HRMS/employee_management/apply_leave_screen.dart';
import 'package:HRMS/employee_management/employee_home_screen.dart';
import 'package:HRMS/employee_management/notification_management_screen.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled,color: Colors.black,),
                label: 'home',
                activeIcon: Icon(Icons.home_outlined,color: Colors.black,)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded,color: Colors.black,),
                label: 'Attendance',
                activeIcon: Icon(Icons.person_outline,color: Colors.black,)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.time_to_leave),
              label: 'Apply Leave',
              activeIcon:Image.asset('assets/video.png',height: 25,width: 25,fit: BoxFit.cover,),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notifications',
              activeIcon:Icon(Icons.notifications_on_outlined),
            ),
          ]),
      body: Center(
        child: widgetList[myIndex],
      ),
    );
  }
}
