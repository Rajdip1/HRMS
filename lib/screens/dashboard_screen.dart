import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:HRMS/screens/widgets/drawer_menu.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int totalEmp = 0;
  int totalLeaveReq = 0;
  int pendingLeaveCount = 0;


  @override
  void initState() {
    super.initState();
    getTotalEmp();
    getTotalLeaveReqCount();
    getPendingLeaveCount();

  }

  void getTotalEmp() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("users").get();
      setState(() {
        totalEmp = snapshot.size;  //it will count number of employees from DB
      });
    }
    catch (e) {
      print('Error getting employee count: $e');
    }
  }

  void getTotalLeaveReqCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("leave_requests").get();
      setState(() {
        totalLeaveReq = snapshot.size;  //it will count number of employees from DB
      });
    }
    catch (e) {
      print('Error getting employee count: $e');
    }
  }

  void getPendingLeaveCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("leave_requests").where('Status', isEqualTo: 'pending').get();

      setState(() {
        pendingLeaveCount = snapshot.size;
      });
    }
    catch (e) {
      print('Error getting in pending leave count: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final themeProvider = Provider.of<ThemeProvider>(context); // Listen for theme changes

    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
          ).createShader(bounds),
          child: Text(
            "HR Home",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: DrawerMenu(onNavigate: (screen) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      }),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                "Welcome To HRMS",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Keeps the gradient effect visible
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.015),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: screenWidth > 600 ? 4 : 2,
              crossAxisSpacing: screenWidth * 0.02,
              mainAxisSpacing: screenHeight * 0.015,
              childAspectRatio: screenWidth > 600 ? 1.8 : 1.5,
              children: [
                _buildDashboardCard("Total Employees", "$totalEmp", Icons.people),
                _buildDashboardCard("Total Departments", "3", Icons.layers),
                // _buildDashboardCard("Total Holidays", "1", Icons.beach_access),
                // _buildDashboardCard("Paid Leaves", "5", Icons.event_available),
                _buildDashboardCard("Total Leaves", "$totalLeaveReq", Icons.person_off),
                _buildDashboardCard("Pending Leave Requests", "$pendingLeaveCount", Icons.pending_actions),
                _buildDashboardCard("Total Check In Today", "1", Icons.login),
                _buildDashboardCard("Total Check Out Today", "0", Icons.logout),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(height: screenHeight * 0.02),
            Center(child: _buildProjectManagementSection(screenWidth)),
            SizedBox(height: screenHeight * 0.02,),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String count, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        // Apply a gradient background
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerRight, child: Icon(icon, color: Colors.black, size: 22)),
          SizedBox(height: 6),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
          SizedBox(height: 4),
          Text(count, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildProjectManagementSection(double screenWidth) {
    return Container(
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
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black), // Changed text color to black
          ),
          SizedBox(height: 15),
          Container(
            height: screenWidth * 0.5,
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
                'assets/project_graph.jpg',
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), // Changed text color to black
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

class TimerBox extends StatelessWidget {
  final String value;

  const TimerBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.pink[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
    );
  }
}