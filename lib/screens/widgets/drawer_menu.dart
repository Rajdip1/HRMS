import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:HRMS/authentication screens/sign_in_screen.dart';
import 'package:HRMS/employee_management/update_request_screen.dart';
import 'package:HRMS/screens/settings_screen.dart';
import 'package:HRMS/leave_management/leave_approval_screen.dart';
import 'package:HRMS/leave_management/leave_reject_screen.dart';
import 'package:HRMS/leave_management/leave_request_screen.dart';
import 'package:HRMS/screens/project_section_screen.dart';
import 'package:HRMS/services/auth_service.dart';
import 'package:HRMS/screens/Department_screen.dart';
import 'package:HRMS/screens/clients_section.dart';
import '../../providers/theme_provider.dart';
import '../attendance_screen.dart';
import '../employee_management_screen.dart';

typedef NavigateCallback = void Function(Widget);

class DrawerMenu extends StatelessWidget {
  final NavigateCallback onNavigate;
  const DrawerMenu({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Color textColor = themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildExpansionTile("Company Management", Icons.business_center, [
            _buildListTile("Department", Icons.account_balance, DepartmentScreen(), context, textColor),
          ], textColor),
          _buildExpansionTile("Employee Management", Icons.people, [
            _buildListTile("Employees", Icons.person, EmployeeManagementScreen(), context, textColor),
            _buildListTile("Update Request", Icons.update, UpdateRequestScreen(), context, textColor),
          ], textColor),
          _buildExpansionTile("Attendance Section", Icons.calendar_month, [
            _buildListTile("Attendance", Icons.calendar_today, AttendanceScreen(), context, textColor),
          ], textColor),
          _buildExpansionTile("Project Management", Icons.add_chart, [
            _buildListTile("Project", Icons.apps_sharp, ProjectSectionScreen(), context, textColor),
            _buildListTile("Clients", Icons.favorite, ClientsScreen(), context, textColor),
          ], textColor),
          _buildExpansionTile("Leave Management", Icons.time_to_leave, [
            _buildListTile("Leave Request", Icons.request_page, LeaveRequestsScreen(), context, textColor),
            _buildListTile("Leave Approval", Icons.approval, LeaveApprovalScreen(), context, textColor),
            _buildListTile("Leave Reject", Icons.cancel, LeaveRejectScreen(), context, textColor),
          ], textColor),
          _buildListTile("Settings", Icons.settings, SettingsScreen(), context, textColor),
          ListTile(
            leading: Icon(Icons.logout, color: textColor),
            title: Text("Log out", style: TextStyle(color: textColor)),
            onTap: () async {
              await AuthServiceMethods().SignOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(color: Colors.blue),
      child: Row(
        children: [
          Image.asset('assets/illustration.png', height: 150, width: 150),
          SizedBox(width: 10),
          Text(
            'HRMS',
            style: TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, Widget screen, BuildContext context, Color textColor) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }

  Widget _buildExpansionTile(String title, IconData icon, List<Widget> children, Color textColor) {
    return ExpansionTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor)),
      children: children,
    );
  }
}
