import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  DateTimeRange? selectedDateRange;
  String getFormattedDateRange() {
    if (selectedDateRange == null) {
      return "Select Date Range";
    }
    return "${DateFormat('MM/dd/yyyy').format(selectedDateRange!.start)} - ${DateFormat('MM/dd/yyyy').format(selectedDateRange!.end)}";
  }

  Future<void> _pickDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDateRange: selectedDateRange,
    );
    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  void _exportCSV() async {
    List<List<String>> csvData = [
      ["Employee Name", "Attendance Type", "Identifier", "Date"],
      ["Sandeep", "Wifi", "20:e8:82:da:6e:50", "05 Mar 2025 11:39:34"],
      ["stafy", "Wifi", "N/A", "04 Mar 2025 20:19:07"],
      ["omar", "Wifi", "N/A", "05 Feb 2025 21:15:19"],
    ];

    String csv = const ListToCsvConverter().convert(csvData);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final path = "$dir/attendance_report.csv";

    final File file = File(path);
    await file.writeAsString(csv);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV Exported: $path')),
    );
  }

  void _reset() {
    setState(() {
      selectedDateRange = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Report')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Attendance Date", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _pickDateRange(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Text(
                      getFormattedDateRange(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _exportCSV,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text('CSV Export'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
