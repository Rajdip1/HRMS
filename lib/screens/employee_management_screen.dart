import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'edit_profile.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  // String selectedDepartment = 'All';
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> employees = [
    {'name': 'Aila Carlos', 'email': 'aila3@yahoo.com', 'department': 'HR'},
    {'name': 'Alam Mata', 'email': 'alam@gmail.com', 'department': 'Sales'},
    {'name': 'Aleksandar Andreev', 'email': 'aleksandr@yahoo.com', 'department': 'IT'},
    {'name': 'keny', 'email': 'keny12@gmail.com', 'department': 'Finance'},
  ];

  void addEmployee(String name, String email, String department) {
    setState(() {
      employees.add({'name': name, 'email': email, 'department': department});
    });
  }

  void showAddEmployeeDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    String selectedDept = 'HR';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Employee"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
              TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
              DropdownButton<String>(
                value: selectedDept,
                items: ['HR', 'Sales', 'IT', 'Finance']
                    .map((String value) => DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDept = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                  addEmployee(nameController.text, emailController.text, selectedDept);
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

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

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.yellowAccent),
                  onPressed: showAddEmployeeDialog,
                  child: Text('Add Employee', style: TextStyle(color: Colors.black)),
                ),
                // SizedBox(width: 30,),
                // TextButton(
                //   onPressed: exportCSV,
                //   child: Text('Export CSV', style: TextStyle(color: Colors.black)),
                // ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.black12,
                        child: Text(
                          employees[index]['name']![0],
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        employees[index]['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employees[index]['email']!,
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          Text(
                            employees[index]['department']!,
                            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit_profile') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfileScreen()),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'edit_profile', child: Text('Edit Profile')),
                          // PopupMenuItem(child: Text('Change Password'), value: 'change_password'),
                          // PopupMenuItem(child: Text('Force Logout'), value: 'force_logout'),
                          PopupMenuItem(value: 'view_details', child: Text('View Details')),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
