import 'package:flutter/material.dart';

class BranchSectionPage extends StatefulWidget {
  const BranchSectionPage({super.key});

  @override
  _BranchSectionPageState createState() => _BranchSectionPageState();
}

class _BranchSectionPageState extends State<BranchSectionPage> {
  List<Map<String, dynamic>> branches = [
    {"name": "mumbai", "address": "olivia wilson", "phone": "1444478412", "employees": 2, "status": true},
    {"name": "Jaipur", "address": "keshav marg", "phone": "8209126381", "employees": 0, "status": true},
    {"name": "baroda", "address": "sardar complex", "phone": "05054267872", "employees": 0, "status": true},
    {"name": "surat", "address": "shiv icon", "phone": "1234567890", "employees": 1, "status": false},
  ];

  List<bool> isExpandedList = List.generate(4, (index) => false);

  void toggleStatus(int index) {
    setState(() {
      branches[index]['status'] = !branches[index]['status'];
    });
  }

  void deleteBranch(int index) {
    setState(() {
      branches.removeAt(index);
      isExpandedList.removeAt(index);
    });
  }

  void editBranchName(int index) {
    TextEditingController nameController = TextEditingController(text: branches[index]['name']);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFF1E1E2C),
          title: Text("Edit Branch Name", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              hintText: "Enter new branch name",
              hintStyle: TextStyle(color: Colors.white54),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Save", style: TextStyle(color: Colors.greenAccent)),
              onPressed: () {
                setState(() {
                  branches[index]['name'] = nameController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    });
  }

  void addNewBranch() {
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController employeeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF1E1E2C),
        title: Text("Add New Branch", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Branch Name",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            TextField(
              controller: addressController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Address",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            TextField(
              controller: phoneController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Phone",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            TextField(
              controller: employeeController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "employees",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ],
        ),

        actions: [
          TextButton(
            child: Text("Cancel", style: TextStyle(color: Colors.redAccent)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Add", style: TextStyle(color: Colors.greenAccent)),
            onPressed: () {
              setState(() {
                branches.add({
                  "name": nameController.text,
                  "address": addressController.text,
                  "phone": phoneController.text,
                  "employees": employeeController.text,
                  "status": true,
                });
                isExpandedList.add(false);
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Branch Section"),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: addNewBranch,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: branches.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> branch = entry.value;
              return Card(
                color: Color(0xFF1E1E2C),
                child: ExpansionTile(
                  title: Text(branch["name"], style: TextStyle(color: Colors.white)),
                  initiallyExpanded: isExpandedList[index],
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpandedList[index] = value;
                    });
                  },
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Address: ${branch["address"]}", style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            title: Text("Phone: ${branch["phone"]}", style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            title: Text("Employees: ${branch["employees"]}", style: TextStyle(color: Colors.white)),
                          ),
                          SwitchListTile(
                            title: Text("Status", style: TextStyle(color: Colors.white)),
                            value: branch["status"],
                            activeColor: Colors.green,
                            onChanged: (value) => toggleStatus(index),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.pink),
                                onPressed: () => editBranchName(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteBranch(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}