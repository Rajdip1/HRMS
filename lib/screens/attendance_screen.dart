import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isCheckedIn = false;
  String? lastCheckIn;
  String? lastCheckOut;

  void _checkIn() {
    setState(() {
      isCheckedIn = true;
      lastCheckIn = DateTime.now().toString();
      lastCheckOut = null;
    });
  }

  void _checkOut() {
    setState(() {
      isCheckedIn = false;
      lastCheckOut = DateTime.now().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Last Check-In: ${lastCheckIn ?? "Not Checked In"}"),
            Text("Last Check-Out: ${lastCheckOut ?? "Not Checked Out"}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isCheckedIn ? _checkOut : _checkIn,
              child: Text(isCheckedIn ? "Check Out" : "Check In"),
            ),
          ],
        ),
      ),
    );
  }
}
