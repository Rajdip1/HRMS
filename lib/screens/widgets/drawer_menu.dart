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
import 'package:HRMS/providers/theme_provider.dart';
import 'package:HRMS/screens/attendance_screen.dart';
import 'package:HRMS/screens/employee_management_screen.dart';

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
            _buildListTile("Department", Icons.account_balance, DepartmentScreen(), context),
          ]),
          _buildExpansionTile("Employee Management", Icons.people, [
            _buildListTile("Employees", Icons.person, EmployeeManagementScreen(), context),
            _buildListTile("Update Request", Icons.update, UpdateRequestScreen(), context),
          ]),
          _buildExpansionTile("Attendance Section", Icons.calendar_month, [
            _buildListTile("Attendance", Icons.calendar_today, AttendanceScreen(), context),
          ]),
          _buildExpansionTile("Project Management", Icons.add_chart, [
            _buildListTile("Project", Icons.apps_sharp, ProjectSectionScreen(), context),
            _buildListTile("Clients", Icons.favorite, ClientsScreen(), context),
          ]),
          _buildExpansionTile("Leave Management", Icons.time_to_leave, [
            _buildListTile("Leave Request", Icons.request_page, LeaveRequestsScreen(), context),
            _buildListTile("Leave Approval", Icons.approval, LeaveApprovalScreen(), context),
            _buildListTile("Leave Reject", Icons.cancel, LeaveRejectScreen(), context),
          ]),
          _buildListTile("Settings", Icons.settings, SettingsScreen(), context),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.blue), // Solid blue icon
            title: _buildGradientText("Log out"), // Gradient text effect
            onTap: () async {
              await AuthServiceMethods().SignOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignInScreen()));
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
          Image.asset('assets/illustration.png', height: 140, width: 140),
          SizedBox(width: 10),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.white, Colors.lightBlueAccent],
            ).createShader(bounds),
            child: Text(
              'HRMS',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Required to make the shader effect visible
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
    );
  }

  Widget _buildExpansionTile(String title, IconData icon, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.blue),
      title: _buildGradientText(title),
      children: children,
    );
  }

  Widget _buildListTile(String title, IconData icon, Widget destination, BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: _buildGradientText(title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
    );
  }


  Widget _buildGradientText(String text) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.blue, Colors.purple],
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
}