import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AttendanceLogsScreen extends StatefulWidget {
  const AttendanceLogsScreen({super.key});

  @override
  State<AttendanceLogsScreen> createState() => _AttendanceLogsScreenState();
}

class _AttendanceLogsScreenState extends State<AttendanceLogsScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedDepartment = 'All Departments';
  List<Map<String, String>> attendanceLogs = [
    {'SN': '1', 'name': 'Sandeep', 'type': 'WiFi', 'identifier': '20:e8:82:da:6e:50', 'date': '05 Mar 2025 11:39:34'},
    {'SN': '2', 'name': 'fevy', 'type': 'WiFi', 'identifier': 'N/A', 'date': '04 Mar 2025 20:19:07'},
    {'SN': '3', 'name': 'omar', 'type': 'WiFi', 'identifier': 'N/A', 'date': '05 Feb 2025 21:15:19'},
    {'SN': '1', 'name': 'liza', 'type': 'WiFi', 'identifier': '21:e6:79:ac:6e:58', 'date': '02 Mar 2025 11:04:09'},
    {'SN': '2', 'name': 'saachin', 'type': 'WiFi', 'identifier': 'N/A', 'date': '06 Mar 2025 21:20:10'},
    {'SN': '3', 'name': 'stafy', 'type': 'WiFi', 'identifier': 'N/A', 'date': '03 Feb 2025 25:10:08'},
    {'SN': '1', 'name': 'moe', 'type': 'WiFi', 'identifier': '22:f7:90:jf:7k:90', 'date': '02 Mar 2025 11:04:09'},
  ];

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

  Future<void> _exportCSV() async {
    List<List<String>> csvData = [
      ["SN", "Employee Name", "Attendance Type", "Identifier", "Date"],
      ...attendanceLogs.map((log) => [log['SN']!, log['name']!, log['type']!, log['identifier']!, log['date']!])
    ];

    String csv = const ListToCsvConverter().convert(csvData);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final path = "$dir/attendance_logs.csv";

    final File file = File(path);
    await file.writeAsString(csv);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV Exported: $path')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportCSV,
          ),
        ],
      ),
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
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: attendanceLogs.map((log) {
                  return Card(
                    color: Colors.black87,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(log['name']!, style: const TextStyle(color: Colors.white)),
                      subtitle: Text("Type: ${log['type']} | Identifier: ${log['identifier']}", style: const TextStyle(color: Colors.white70)),
                      trailing: Text(log['date']!, style: const TextStyle(color: Colors.white70)),
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
