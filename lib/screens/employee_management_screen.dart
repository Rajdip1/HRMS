import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';
import 'edit_profile.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  // String selectedDepartment = 'All';
  TextEditingController searchController = TextEditingController();

  String? id = FirebaseAuth.instance.currentUser?.uid;
  Stream<QuerySnapshot>? employeeStream;

  getOnTheLoad() async {
    employeeStream = DatabaseMethods().getAllEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getOnTheLoad();
  }

  //delete
  deleteData(String empId) async {
    await DatabaseMethods().deleteEmployeeDetails(empId);
  }


  // void addEmployee(String name, String email, String department) {
  //   setState(() {
  //     employees.add({'name': name, 'email': email, 'department': department});
  //   });
  // }

  // void showAddEmployeeDialog() {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController emailController = TextEditingController();
  //   String selectedDept = 'HR';
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Add Employee"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
  //             TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
  //             DropdownButton<String>(
  //               value: selectedDept,
  //               items: ['HR', 'Sales', 'IT', 'Finance']
  //                   .map((String value) => DropdownMenuItem(value: value, child: Text(value)))
  //                   .toList(),
  //               onChanged: (value) {
  //                 setState(() {
  //                   selectedDept = value!;
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
  //           ElevatedButton(
  //             onPressed: () {
  //               if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
  //                 addEmployee(nameController.text, emailController.text, selectedDept);
  //                 Navigator.pop(context);
  //               }
  //             },
  //             child: Text("Add"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> exportCSV() async {
  //   List<List<String>> data = [
  //     ["Name", "Email", "Department"],
  //     ...employees.map((e) => [e["name"]!, e["email"]!, e["department"]!]),
  //   ];
  //
  //   String csvData = const ListToCsvConverter().convert(data);
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File("${directory.path}/employees.csv");
  //
  //   await file.writeAsString(csvData);
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("CSV Exported: ${file.path}")));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: BoxDecoration(color: Colors.black),
      //         child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
      //       ),
      //       ListTile(title: Text('Dashboard'), onTap: () {}),
      //       ListTile(title: Text('Employee Management'), onTap: () {}),
      //       ListTile(title: Text('Departments'), onTap: () {}),
      //       ListTile(title: Text('Settings'), onTap: () {}),
      //     ],
      //   ),
      // ),

      appBar: AppBar(
        title: Text('Employee Management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey,
        // actions: [
        //   TextButton(
        //     onPressed: showAddEmployeeDialog,
        //     child: Text('Add Employee', style: TextStyle(color: Colors.white)),
        //   ),
        //   TextButton(
        //     onPressed: exportCSV,
        //     child: Text('Export CSV', style: TextStyle(color: Colors.white)),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // DropdownButton<String>(
                //   value: selectedDepartment,
                //   items: ['All', 'Sales', 'HR', 'IT', 'Finance']
                //       .map((String value) => DropdownMenuItem(value: value, child: Text(value)))
                //       .toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedDepartment = value!;
                //     });
                //   },
                // ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Employee',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                // IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
              ],
            ),
            SizedBox(height: 10),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Total Employees: ${employees.length}',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            //     ElevatedButton(
            //       onPressed: () {},
            //       child: Text('Generate Report'),
            //       style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            //     ),
            //   ],
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextButton(
            //       style: TextButton.styleFrom(backgroundColor: Colors.yellowAccent),
            //       onPressed: showAddEmployeeDialog,
            //       child: Text('Add Employee', style: TextStyle(color: Colors.black)),
            //     ),
            //     // SizedBox(width: 30,),
            //     // TextButton(
            //     //   onPressed: exportCSV,
            //     //   child: Text('Export CSV', style: TextStyle(color: Colors.black)),
            //     // ),
            //   ],
            // ),

            // Expanded(
            //   child: ListView.builder(
            //     itemCount: employees.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //         elevation: 4,
            //         margin: EdgeInsets.symmetric(vertical: 8),
            //         child: ListTile(
            //           contentPadding: EdgeInsets.all(10),
            //           leading: CircleAvatar(
            //             radius: 25,
            //             backgroundColor: Colors.black12,
            //             child: Text(
            //               employees[index]['name']![0],
            //               style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //           title: Text(
            //             employees[index]['name']!,
            //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            //           ),
            //           subtitle: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 employees[index]['email']!,
            //                 style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            //               ),
            //               Text(
            //                 employees[index]['department']!,
            //                 style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            //               ),
            //             ],
            //           ),
            //           trailing: PopupMenuButton<String>(
            //             onSelected: (value) {
            //               if (value == 'edit_profile') {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(builder: (context) => EditProfileScreen()),
            //                 );
            //               }
            //             },
            //             itemBuilder: (context) => [
            //               PopupMenuItem(value: 'edit_profile', child: Text('Edit Profile')),
            //               // PopupMenuItem(child: Text('Change Password'), value: 'change_password'),
            //               // PopupMenuItem(child: Text('Force Logout'), value: 'force_logout'),
            //               PopupMenuItem(value: 'view_details', child: Text('View Details')),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

            Expanded(child: allEmployeeDetails(),)
          ],
        ),
      ),
    );
  }

  Widget allEmployeeDetails() {
    return SizedBox(
      height: 550,
      child: StreamBuilder<QuerySnapshot>(
        stream: DatabaseMethods().getAllEmployeeDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No users found"));
          }
      
          // Convert documents into a list
          var users = snapshot.data!.docs;
      
          return Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index].data() as Map<String, dynamic>;
                  
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(user["Name"] ?? "No Name"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${user["email"] ?? "No Email"}"),
                        Text("Role: ${user["role"] ?? "No Role"}"),
                        Text("Department: ${user["Department"] ?? "Not Assigned"}"),
                      ],
                    ),
                    leading: Icon(Icons.person),
                    trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                    if (value == 'edit_profile') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()),
                      );
                    }
                    else if(value == 'delete') {
                      deleteData(users[index].id);  //passed firestore doc id
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'edit_profile', child: Text('Edit Profile')),
                    PopupMenuItem(child: Text('Delete'), value: 'delete'),
                    // PopupMenuItem(child: Text('Force Logout'), value: 'force_logout'),
                    PopupMenuItem(value: 'view_details', child: Text('View Details')),
                  ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
