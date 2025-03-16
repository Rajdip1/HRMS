import 'package:demo/authentication%20screens/sign_in_screen.dart';
import 'package:demo/employee_management/apply_leave_screen.dart';
import 'package:demo/employee_management/employee_edit_details_form.dart';
import 'package:demo/services/auth_service.dart';
import 'package:flutter/material.dart';

class EmployeeHomeScreen extends StatefulWidget {
  const EmployeeHomeScreen({super.key});

  @override
  State<EmployeeHomeScreen> createState() => _EmployeeHomeScreenState();
}

class _EmployeeHomeScreenState extends State<EmployeeHomeScreen> {
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
                    margin: EdgeInsets.only(right: 145),
                    child: Text(
                      'Welcome to HRMS',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
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
                              'Name :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16,),
                            ),
                            SizedBox(height: 8.0,),
                            Text(
                              'Email :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,),
                            ),
                            SizedBox(height: 8.0,),
                            Text(
                              'Role :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,),
                            ),
                            SizedBox(height: 8.0,),
                            Text(
                              'Department :',
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // SizedBox(height: 10,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       width: 180,
                //       height: 130,
                //       child: Card(
                //         color: Colors.lightBlue,
                //         elevation: 8,
                //         child: Column(
                //           children: [
                //             Icon(Icons.time_to_leave),
                //             Text('Apply Leave')
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 10,),
                //     SizedBox(
                //       width: 180,
                //       height: 130,
                //       child: Card(
                //         color: Colors.lightBlue,
                //         elevation: 8,
                //         child: Column(
                //           children: [
                //             Icon(Icons.payments),
                //             Text('Payrolls')
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       width: 180,
                //       height: 130,
                //       child: Card(
                //         color: Colors.lightBlue,
                //         elevation: 8,
                //         child: Column(
                //           children: [
                //             Icon(Icons.calendar_today),
                //             Text('Calendar')
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(width: 10,),
                //     SizedBox(
                //       width: 180,
                //       height: 130,
                //       child: Card(
                //         color: Colors.lightBlue,
                //         elevation: 8,
                //         child: Column(
                //           children: [
                //             Icon(Icons.developer_board),
                //             Text('Projects')
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: 20.0,),

                //time box
                Container(
                  margin: EdgeInsets.only(left: 15,right: 15),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child:  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TimerBox(value: "00"),
                          const SizedBox(width: 8),
                          TimerBox(value: "00"),
                          const SizedBox(width: 8),
                          TimerBox(value: "00"),
                          const SizedBox(width: 8),
                          const Text(
                            "HRS",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      const Text(
                        "GENERAL 09:00 AM TO 06:00 PM",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }

  Widget _widgetDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey),
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
              )),
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
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text(
              'Attendance',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {},
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {},
          ),
          SizedBox(
            height: 5,
          ),
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
          SizedBox(
            height: 5,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Payrolls',
              style: TextStyle(color: Colors.black),
            ),
            tileColor: Colors.white,
            onTap: () {},
          ),
          // SizedBox(height: 5,),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings',style: TextStyle(color: Colors.black),),
          //   tileColor: Colors.white,
          //   onTap: () {},
          // ),
          SizedBox(
            height: 5,
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
