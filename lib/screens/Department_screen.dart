
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DepartmentScreen(),
    );
  }
}

class DepartmentScreen extends StatefulWidget {
  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  String selectedBranch = "Select Branch";
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> departments = [
    {"id": 1, "name": "alex", "head": "Admin", "employees": 2, "address": "gandhi dham", "phone": "2237466598", "branch": "mumbai", "status": true},
    {"id": 2, "name": "elevater", "head": "manager", "employees": 3, "address": "ansuya complex", "phone": "9225045625", "branch": "rajkot", "status": true},
    {"id": 3, "name": "lili", "head": "HR", "employees": 1, "address": "sayaji circle", "phone": "8209126381", "branch": "Jaipur", "status": true},
  ];

  List<String> branches = ["Select Branch", "Kolkatta", "Ahmedabad", "Jaipur","Dubai","Canada","Gandhinagar"];

  void toggleStatus(int index) {
    setState(() {
      departments[index]['status'] = !departments[index]['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Department Management")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // DropdownButton<String>(
                //   value: selectedBranch,
                //   items: branches.map((String branch) {
                //     return DropdownMenuItem<String>(
                //       value: branch,
                //       child: Text(branch),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       selectedBranch = value!;
                //     });
                //   },
                // ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search by Department Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 15,
                  columns: [
                    DataColumn(label: Text("No")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Department Head")),
                    DataColumn(label: Text("Employees")),
                    DataColumn(label: Text("Address")),
                    DataColumn(label: Text("Phone")),
                    DataColumn(label: Text("Branch Name")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows: departments.map((dept) {
                    return DataRow(cells: [
                      DataCell(Text(dept["id"].toString())),
                      DataCell(Text(dept["name"])),
                      DataCell(Text(dept["head"])),
                      DataCell(Text(dept["employees"].toString())),
                      DataCell(Text(dept["address"])),
                      DataCell(Text(dept["phone"])),
                      DataCell(Text(dept["branch"])),
                      DataCell(Switch(
                        value: dept["status"],
                        onChanged: (bool value) {
                          setState(() {
                            dept["status"] = value;
                          });
                        },
                      )),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
