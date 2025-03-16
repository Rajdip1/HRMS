import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  DateTime selectedDate = DateTime.now();
  String selectedDepartment = 'All Departments';
  List<Map<String, dynamic>> attendanceList = [];
  List<Map<String, dynamic>> originalList = [];

  @override
  void initState() {
    super.initState();
    attendanceList = [
      {'name': 'sachin', 'hours': '2 h 40 m', 'status': 'Approved', 'shift': 'Morning'},
      {'name': 'Sandeep', 'hours': '1 h 46 m', 'status': 'Approved', 'shift': 'Evening'},
      {'name': 'Fevy', 'hours': '--', 'status': 'Pending', 'shift': 'Night'},
      {'name': 'omar', 'hours': '5 h 60 m', 'status': 'Approved', 'shift': 'Morning'},
      {'name': 'Stafy', 'hours': '--', 'status': 'Pending', 'shift': 'Evening'},
      {'name': 'liza', 'hours': '--', 'status': 'Pending', 'shift': 'Night'},
      {'name': 'Moe', 'hours': '--', 'status': 'Pending', 'shift': 'Morning'},
    ];
    originalList = List.from(attendanceList);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _filterApproved() {
    setState(() {
      attendanceList = originalList.where((employee) => employee['status'] == 'Approved').toList();
    });
  }

  void _resetList() {
    setState(() {
      attendanceList = List.from(originalList);
    });
  }

  Future<void> _exportCSV() async {
    List<List<String>> csvData = [
      ["Name", "Hours", "Status", "Shift"],
      ...attendanceList.map((item) => [item['name'], item['hours'], item['status'], item['shift']])
    ];

    String csv = const ListToCsvConverter().convert(csvData);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final path = "$dir/attendance.csv";

    final File file = File(path);
    await file.writeAsString(csv);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV Exported: $path')),
    );
  }

  void _showConfirmationDialog(String action, Map<String, dynamic> attendance) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$action Confirmation'),
          content: Text('Are you sure you want to $action for ${attendance['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (action == 'Check In') {
                    attendance['status'] = 'Approved';
                  } else if (action == 'Check Out') {
                    attendance['status'] = 'Checked Out';
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                  ),
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDepartment,
                    items: ['All Departments', 'HR', 'IT', 'Finance']
                        .map((String dept) => DropdownMenuItem<String>(
                      value: dept,
                      child: Text(dept),
                    ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDepartment = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: attendanceList.map((attendance) {
                  return Card(
                    color: Colors.black87,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(attendance['name'], style: const TextStyle(color: Colors.white)),
                      subtitle: Text("Status: ${attendance['status']}", style: const TextStyle(color: Colors.white70)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () => _showConfirmationDialog('Check In', attendance),
                            child: const Text('Check In'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _showConfirmationDialog('Check Out', attendance),
                            child: const Text('Check Out'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
