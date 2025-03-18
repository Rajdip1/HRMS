import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotificationManagementScreen(),
  ));
}

class NotificationManagementScreen extends StatefulWidget {
  @override
  _NotificationManagementScreenState createState() =>
      _NotificationManagementScreenState();
}

class _NotificationManagementScreenState
    extends State<NotificationManagementScreen> {
  String selectedType = "All Types";

  List<Map<String, dynamic>> notifications = [
    {
      "title": "Support Notification",
      "date": "Mar 11 2025 14:33",
      "type": "Support",
      "member": "Admin",
      "description": "Your Support Request is in progress.",
      "status": true
    },
    {
      "title": "Leave Request Notification",
      "date": "Mar 11 2025 13:40",
      "type": "Leave",
      "member": "HR",
      "description": "Your leave request has been approved.",
      "status": true
    },
    {
      "title": "Medical Leave Notification",
      "date": "Mar 10 2025 10:30",
      "type": "Medical",
      "member": "HR",
      "description": "Your medical leave is under review.",
      "status": false
    },
    {
      "title": "Payroll Notification",
      "date": "Mar 09 2025 16:20",
      "type": "Payroll",
      "member": "Finance",
      "description": "Your salary has been processed.",
      "status": true
    },
  ];

  final List<String> notificationTypes = [
    "General",
    "Comment",
    "Project",
    "Task",
    "Attendance",
    "Leave",
    "Support",
    "Medical",
    "Payroll",
    "Resignation",
    "Termination"
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredNotifications = selectedType == "All Types"
        ? notifications
        : notifications.where((n) => n["type"] == selectedType).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Management"),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Dropdown & Buttons
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    items: ["All Types", ...notificationTypes].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      border: OutlineInputBorder(),
                      labelText: "Select Type",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _showAddNotificationPopup,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("Add"),
                ),
              ],
            ),
            SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 10,
                  columns: [
                    DataColumn(label: Text("#")),
                    DataColumn(label: Text("Title")),
                    DataColumn(label: Text("Published Date")),
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("Description")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Action")),
                  ],
                  rows: List.generate(filteredNotifications.length, (index) {
                    final notification = filteredNotifications[index];
                    return DataRow(cells: [
                      DataCell(Text("${index + 1}")),
                      DataCell(Text(notification["title"]!)),
                      DataCell(Text(notification["date"]!)),
                      DataCell(Text(notification["type"]!)),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.remove_red_eye, color: Colors.redAccent),
                          onPressed: () {
                            _showNotificationDetails(context, notification);
                          },
                        ),
                      ),
                      DataCell(
                        Switch(
                          value: notification["status"],
                          onChanged: (val) {
                            setState(() {
                              notifications.firstWhere(
                                      (n) => n["title"] == notification["title"])["status"] = val;
                            });
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteNotification(notification);
                          },
                        ),
                      ),
                    ]);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(notification["title"]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Date: ${notification["date"]}"),
              Text("Type: ${notification["type"]}"),
              Text("Member: ${notification["member"]}"),
              SizedBox(height: 10),
              Text(notification["description"]),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _deleteNotification(Map<String, dynamic> notification) {
    setState(() {
      notifications.remove(notification);
    });
  }

  void _showAddNotificationPopup() {
    TextEditingController titleController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController memberController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    String selectedPopupType = notificationTypes.first;
    bool status = true;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text("Add Notification", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Date",
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedPopupType,
                items: notificationTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  selectedPopupType = value!;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(),
                  labelText: "Select Type",
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: memberController,
                decoration: InputDecoration(
                  labelText: "Notified Member",
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Description",
                  filled: true,
                  fillColor: Colors.black12,
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(child: Text("Cancel", style: TextStyle(color: Colors.white)), onPressed: () => Navigator.of(context).pop()),
            TextButton(child: Text("Add", style: TextStyle(color: Colors.white)), onPressed: () {
              setState(() {
                notifications.add({
                  "title": titleController.text,
                  "date": dateController.text,
                  "type": selectedPopupType,
                  "member": memberController.text,
                  "description": descriptionController.text,
                  "status": status,
                });
              });
              Navigator.of(context).pop();
            }),
          ],
        );
      },
    );
  }
}
