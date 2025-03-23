import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/authentication%20screens/sign_in_screen.dart';
import 'package:demo/employee_management/apply_leave_screen.dart';
import 'package:demo/employee_management/employee_edit_details_form.dart';
import 'package:demo/screens/attendance_screen.dart';
import 'package:demo/screens/settings_screen.dart';
import 'package:demo/services/auth_service.dart';
import 'package:demo/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController departmentController = new TextEditingController();

  String? id = FirebaseAuth.instance.currentUser?.uid;


  Stream<DocumentSnapshot>? EmployeeStream;

  getOnTheLoad() async {
    EmployeeStream = DatabaseMethods().getEmployeeDetails(id!);
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Employee Home'),
        ),
        drawer: _widgetDrawer(context),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      'Welcome to HRMS',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                ),
                SizedBox(height: 20,),
                Center(
                  child: employeeDetails(),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(height: 20.0,),

                //time box
                // Container(
                //   margin: EdgeInsets.only(left: 15,right: 15),
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
                // )

              ],
            ),
          ),
        ));
  }

  //function to display data of logged in employee
  Widget employeeDetails() {

    return StreamBuilder<DocumentSnapshot>(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // print("Snapshot Data: ${snapshot.data?.data()}");
          //
          // print("Snapshot hasData: ${snapshot.hasData}");
          // print("Snapshot data: ${snapshot.data}");
          // print("Document exists: ${snapshot.data?.exists}");

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
            return Center(child: Text('No data found'),);
          }

          var employeeData = snapshot.data!.data() as Map<String,dynamic>;

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              child: Card(
                color: Colors.blue[200],
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name : ${employeeData['Name']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        'Email : ${employeeData['Email']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        'Role : Employee',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,),
                      ),
                      SizedBox(height: 8.0,),
                      Text(
                        'Department : ${employeeData['Department']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _widgetDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  Container(
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
                ],
              )
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmployeeEditDetailsForm()));
            },
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text(
              'Attendance',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendanceScreen()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text(
          //     'Notifications',
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   tileColor: Colors.white,
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.time_to_leave),
            title: Text(
              'Apply Leave',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ApplyLeaveScreen()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text(
          //     'Payrolls',
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   tileColor: Colors.white,
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Log out',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () async {
              await AuthServiceMethods().SignOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          )
        ],
      ),
    );
  }
}

// class TimerBox extends StatelessWidget {
//   final String value;
//
//   const TimerBox({super.key, required this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.pink[100],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         value,
//         style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }