import 'package:flutter/material.dart';
import 'package:demo/screens/widgets/drawer_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "HR Home",
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          // IconButton(icon: Icon(Icons.notifications, color: Colors.black), onPressed: () {}),
          // IconButton(icon: Icon(Icons.settings, color: Colors.black), onPressed: () {}),
        ],
      ),
      drawer: DrawerMenu(onNavigate: (screen) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      }),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03, vertical: screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome To HRMS",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
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
                _buildDashboardCard("Total Employees", "2", Icons.people),
                _buildDashboardCard("Total Departments", "3", Icons.layers),
                _buildDashboardCard("Total Holidays", "1", Icons.beach_access),
                _buildDashboardCard("Paid Leaves", "273", Icons.event_available),
                _buildDashboardCard("On Leave Today", "0", Icons.person_off),
                _buildDashboardCard("Pending Leave Requests", "0", Icons.pending_actions),
                _buildDashboardCard("Total Check In Today", "1", Icons.login),
                _buildDashboardCard("Total Check Out Today", "0", Icons.logout),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            //time box
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   decoration: BoxDecoration(
            //       color: Colors.black87,
            //       borderRadius: BorderRadius.circular(12)
            //   ),
            //   child:  Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           TimerBox(value: "00"),
            //           const SizedBox(width: 8),
            //           TimerBox(value: "00"),
            //           const SizedBox(width: 8),
            //           TimerBox(value: "00"),
            //           const SizedBox(width: 8),
            //           const Text(
            //             "HRS",
            //             style: TextStyle(color: Colors.white, fontSize: 16),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 8),
            //       const Text(
            //         "GENERAL 09:00 AM TO 06:00 PM",
            //         style: TextStyle(color: Colors.white70, fontSize: 14),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.02),
            Center(child: _buildProjectManagementSection(screenWidth)),
            SizedBox(height: screenHeight * 0.02,),
            // SizedBox(height: screenHeight * 0.02),
            // _buildLiveClock(screenWidth),
            // SizedBox(height: screenHeight * 0.02),
            // // _buildTopClients(),
            // SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(String title, String count, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
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
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Project Management",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 15),
          Container(
            height: screenWidth * 0.5,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/illustration.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
    padding: EdgeInsets.all(15.0),
    decoration: BoxDecoration(
    color: Colors.black54,
    borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Text(
    "Task Details", textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    SizedBox(height: 16),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      _buildStatusIndicator("Pending", Colors.pinkAccent, 5),
      SizedBox(width: 10),
      _buildStatusIndicator("On Hold", Colors.lightBlueAccent, 2),
      SizedBox(width: 10),
      _buildStatusIndicator("In Progress", Colors.blue, 8),
      SizedBox(width: 10),
      _buildStatusIndicator("Completed", Colors.pinkAccent, 12),
      SizedBox(width: 10),
      _buildStatusIndicator("Cancelled", Colors.lightBlueAccent, 3),
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

  // Widget _buildLiveClock(double screenWidth) {
  //   return Container(
  //     width: screenWidth * 0.9,
  //     padding: EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.blue,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Column(
  //       children: [
  //         Icon(Icons.access_time, color: Colors.black, size: 60),
  //         SizedBox(height: 8),
  //         ElevatedButton(
  //           onPressed: () {},
  //           style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //           child: Text("Punch Out"),
  //         ),
  //         SizedBox(height: 8),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("Check In At", style: TextStyle(color: Colors.black)),
  //             Text("01:53:25", style: TextStyle(color: Colors.black)),
  //           ],
  //         ),
  //         SizedBox(height: 4),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("Check Out At", style: TextStyle(color: Colors.black)),
  //             Text("--!--", style: TextStyle(color: Colors.black)),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildTopClients() {
  //   return Container(
  //     padding: EdgeInsets.all(8.0),
  //     decoration: BoxDecoration(
  //       color: Colors.blue,
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text(
  //           "Top Clients",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
  //         ),
  //         Divider(color: Colors.white70),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               Expanded(child: Text("Name", style: TextStyle(color: Colors.black))),
  //               Expanded(child: Text("Email", style: TextStyle(color: Colors.black))),
  //               Expanded(child: Text("Contact", style: TextStyle(color: Colors.black))),
  //               Expanded(child: Text("Project", style: TextStyle(color: Colors.black))),
  //             ],
  //           ),
  //         ),
  //         Divider(color: Colors.white70),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                   flex: 1,
  //                   child: Text("Sakshi Makwana",
  //                       style: TextStyle(color: Colors.black , fontSize: 10),
  //                       textAlign: TextAlign.center)),
  //               Expanded(
  //                   flex: 2,
  //                   child: Text("sakshi12@gmail.com",
  //                       style: TextStyle(color: Colors.black, fontSize: 10),
  //                       textAlign: TextAlign.center)),
  //               Expanded(
  //                   flex: 2,
  //                   child: Text("8511696999",
  //                       style: TextStyle(color: Colors.black,fontSize: 10),
  //                       textAlign: TextAlign.center)),
  //               Expanded(
  //                   flex: 1,
  //                   child: Text("1",
  //                       style: TextStyle(color: Colors.black,fontSize: 10),
  //                       textAlign: TextAlign.center)),
  //             ],
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }


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
