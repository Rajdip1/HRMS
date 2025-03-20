import 'package:demo/authentication%20screens/sign_in_screen.dart';
import 'package:demo/screens/settings_screen.dart';
import 'package:demo/leave_management/leave_approval_screen.dart';
import 'package:demo/leave_management/leave_reject_screen.dart';
import 'package:demo/leave_management/leave_request_screen.dart';
import 'package:demo/screens/project_section_screen.dart';
import 'package:demo/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/Department_screen.dart';
import 'package:demo/screens/attendance_report.dart';
import 'package:demo/screens/clients_section.dart';
import 'package:demo/screens/company_profile.dart';
import '../attendance_logs_screen.dart';
import '../attendance_screen.dart';
import '../employee_management_screen.dart';

typedef NavigateCallback = void Function(Widget);

class DrawerMenu extends StatelessWidget {
  final NavigateCallback onNavigate;

  const DrawerMenu({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/illustration.png', // Replace with your logo asset
                  height: 180,
                  width: 180,
                ),
                SizedBox(width: 10),
                Text(
                  'HRMS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // ListTile(
          //   leading: Icon(Icons.dashboard, color: Colors.black),
          //   title: Text("Dashboard", style: TextStyle(color: Colors.black)),
          //   onTap: () => onNavigate(Center(child: Text("Dashboard Content", style: TextStyle(color: Colors.black)))),
          // ),

          ExpansionTile(
            leading: Icon(Icons.business_center, color: Colors.black),
            title: Text("Company Management", style: TextStyle(color: Colors.black)),
            children: [
              ListTile(
                leading: Icon(Icons.apartment, color: Colors.black),
                title: Text("Company", style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyProfilePage()));
                },
              ),

              // ListTile(
              //   leading: Icon(Icons.location_city, color: Colors.black),
              //   title: Text("Branch", style: TextStyle(color: Colors.black)),
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => BranchSectionPage()));
              //   },
              // ),

              ListTile(
                leading: Icon(Icons.account_balance, color: Colors.black),
                title: Text("Department", style: TextStyle(color: Colors.black)),
                onTap: ()  => onNavigate(DepartmentScreen())
              ),
              // ListTile(
              //   leading: Icon(Icons.work, color: Colors.white70),
              //   title: Text("Post", style: TextStyle(color: Colors.white70)),
              //   onTap: () => onNavigate(PostSectionPage())
              // ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.people, color: Colors.black),
            title: Text("Employee Management", style: TextStyle(color: Colors.black)),
            children: [
              ListTile(
                leading: Icon(Icons.person, color: Colors.black),
                title: Text("Employees", style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeManagementScreen()));
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.access_time, color: Colors.black),
            title: Text("Attendance Section", style: TextStyle(color: Colors.black)),
            children: [
              ListTile(
                leading: Icon(Icons.timer_sharp, color: Colors.black),
                title: Text("Attendance", style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.login_sharp, color: Colors.black),
                title: Text("Attendance Logs", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceLogsScreen()));
                  },
              ),
              ListTile(
                leading: Icon(Icons.report, color: Colors.black),
                title: Text("Attendance Report", style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceReportScreen()));
                  },
              ),
            ],
          ),
    ExpansionTile(
    leading: Icon(Icons.timer_sharp, color: Colors.black),
    title: Text("Project Managment", style: TextStyle(color: Colors.black)),
    children: [
      ListTile(
        leading: Icon(Icons.apps_sharp, color: Colors.black),
        title: Text("Project", style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectSectionScreen()));
        },
      ),
      ListTile(
        leading: Icon(Icons.favorite, color: Colors.black),
        title: Text("Clients", style: TextStyle(color: Colors.black)),
        onTap: () => onNavigate(ProjectManagementClient()),
      ),
         ],
         ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.black),
            // title: Text("Notice", style: TextStyle(color: Colors.black)),
            title: Text("Notifications", style: TextStyle(color: Colors.black)),
            onTap: () {},
          ),
          // ExpansionTile(
          //   leading: Icon(Icons.monetization_on, color: Colors.black),
          //   title: Text("Payroll Management", style: TextStyle(color: Colors.black)),
          //   children: [
          //     ListTile(
          //         leading: Icon(Icons.payments_sharp, color: Colors.black),
          //         title: Text("Payroll", style: TextStyle(color: Colors.black)),
          //            onTap: () {}),
          //     ListTile(
          //         leading: Icon(Icons.payment, color: Colors.black),
          //         title: Text("Advance Salary", style: TextStyle(color: Colors.black)),
          //            onTap: () {}),
          //     ListTile(
          //         leading: Icon(Icons.payments_outlined, color: Colors.black),
          //         title: Text("Employee Salary", style: TextStyle(color: Colors.black)),
          //           onTap: () {}),
          //     ListTile(
          //         leading: Icon(Icons.account_balance_outlined, color: Colors.black),
          //         title: Text("Tada", style: TextStyle(color: Colors.black)),
          //           onTap: () {}),
          //   ],
          // ),
    ExpansionTile(
    leading: Icon(Icons.time_to_leave_sharp, color: Colors.black),
    title: Text("Leave managment", style: TextStyle(color: Colors.black)),
    children: [
          // ListTile(
          //   leading: Icon(Icons.calendar_today, color: Colors.black),
          //   title: Text("Leave Types", style: TextStyle(color: Colors.black)),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.request_page, color: Colors.black),
            title: Text("Leave Request", style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRequestsScreen()));
            },
      ),
      // ListTile(
      //   leading: Icon(Icons.time_to_leave_outlined, color: Colors.black),
      //   title: Text("Time Leave Request ", style: TextStyle(color: Colors.black)),
      //   onTap: () {},
      // ),
      ListTile(
        leading: Icon(Icons.approval, color: Colors.black),
        title: Text("Leave Approval", style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveApprovalScreen(leaveRequests: leaveRequests)));
        },
      ),
      ListTile(
        leading: Icon(Icons.approval, color: Colors.black),
        title: Text("Leave Reject", style: TextStyle(color: Colors.black)),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveRejectedScreen(leaveRequests: leaveRequests)));
        },
      ),
    ],
    ),
          // ListTile(
          //   leading: Icon(Icons.video_call, color: Colors.black),
          //   title: Text("Team Meeting", style: TextStyle(color: Colors.black)),
          //   onTap: () {},
          // ),

          // ExpansionTile(
          //   leading: Icon(Icons.schedule, color: Colors.black),
          //   title: Text("Shift Management", style: TextStyle(color: Colors.black)),
          //   children: [
          //     ListTile(
          //       leading: Icon(Icons.filter_tilt_shift_outlined, color: Colors.black),
          //       title: Text("Shift Time", style: TextStyle(color: Colors.black)),
          //       onTap: () {},
          //     ),
          //   ],
          // ),

          // ListTile(
          //   leading: Icon(Icons.content_paste_sharp, color: Colors.black),
          //   title: Text("Content Managment", style: TextStyle(color: Colors.black)),
          //   onTap: () {},
          // ),

          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text("Settings", style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text("Log out", style: TextStyle(color: Colors.black)),
            onTap: () async {
              await AuthServiceMethods().SignOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}
