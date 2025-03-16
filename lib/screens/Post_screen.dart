import 'package:flutter/material.dart';

class PostSectionPage extends StatefulWidget {
  @override
  _PostSectionPageState createState() => _PostSectionPageState();
}

class _PostSectionPageState extends State<PostSectionPage> {
  List<Map<String, dynamic>> posts = [
    {'id': 1, 'name': 'Training Specialist', 'department': 'HR', 'employees': 0, 'status': true},
    {'id': 2, 'name': 'HR Manager', 'department': 'HR', 'employees': 2, 'status': true},
    {'id': 3, 'name': 'Network Administrator', 'department': 'Networking', 'employees': 1, 'status': true},
    {'id': 4, 'name': 'Brand Manager', 'department': 'Brand Analyst', 'employees': 1, 'status': false},
    {'id': 5, 'name': 'Coordinator', 'department': 'Marketing', 'employees': 0, 'status': false},
  ];

  void toggleStatus(int index) {
    setState(() {
      posts[index]['status'] = !posts[index]['status'];
    });
  }
  void editPost(int index, String name, String department, int employees) {
    setState(() {
      posts[index]['name'] = name;
      posts[index]['department'] = department;
      posts[index]['employees'] = employees;
    });
  }

  void deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
  }

  void showEditPostDialog(int index) {
    TextEditingController nameController = TextEditingController(text: posts[index]['name']);
    TextEditingController departmentController = TextEditingController(text: posts[index]['department']);
    TextEditingController employeesController = TextEditingController(text: posts[index]['employees'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Post Name"),
              ),
              TextField(
                controller: departmentController,
                decoration: InputDecoration(labelText: "Department"),
              ),
              TextField(
                controller: employeesController,
                decoration: InputDecoration(labelText: "Total Employees"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    departmentController.text.isNotEmpty &&
                    employeesController.text.isNotEmpty) {
                  editPost(
                    index,
                    nameController.text,
                    departmentController.text,
                    int.parse(employeesController.text),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }



  void addPost(String name, String department, int employees) {
    setState(() {
      posts.add({
        'id': posts.length + 1,
        'name': name,
        'department': department,
        'employees': employees,
        'status': true,
      });
    });
  }

  void showAddPostDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController employeesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Post"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: "Post Name")),
              TextField(controller: departmentController, decoration: InputDecoration(labelText: "Department")),
              TextField(controller: employeesController, decoration: InputDecoration(labelText: "Total Employees"), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && departmentController.text.isNotEmpty && employeesController.text.isNotEmpty) {
                  addPost(nameController.text, departmentController.text, int.parse(employeesController.text));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Section"), backgroundColor: Colors.black12, elevation: 1, foregroundColor: Colors.white),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: showAddPostDialog,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                child: Text("+ Add Post"),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enables scrolling for small screens
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return DataTable(
                      columnSpacing: 20,
                      columns: [
                        DataColumn(label: Text("No")),
                        DataColumn(label: Text("POST NAME")),
                        DataColumn(label: Text("DEPARTMENT")),
                        DataColumn(label: Text("TOTAL EMPLOYEE")),
                        DataColumn(label: Text("STATUS")),
                        DataColumn(label: Text("ACTION")),
                      ],
                      rows: posts.map((post) => DataRow(
                        cells: [
                          DataCell(Text("${post['id']}")),
                          DataCell(Text(post['name'])),
                          DataCell(Text(post['department'])),
                          DataCell(Text("${post['employees']}")),
                          DataCell(Switch(value: post['status'], onChanged: (val) => toggleStatus(posts.indexOf(post)))),
                          DataCell(Row(children: [
                            IconButton(icon: Icon(Icons.edit, color: Colors.pink), onPressed: () => showEditPostDialog(posts.indexOf(post))),
                            IconButton(icon: Icon(Icons.delete, color: Colors.pink), onPressed: () => deletePost(posts.indexOf(post))),
                          ])),
                        ],
                      )).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
