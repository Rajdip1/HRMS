import 'package:flutter/material.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LeaveDetail(title: 'type', value: 'Casual'),
            LeaveDetail(title: 'Cause', value: 'Trip to Anand'),
            LeaveDetail(title: 'From', value: 'Mon, 21 Dec 2025'),
            LeaveDetail(title: 'To', value: 'Wed, 23 Dec 2025'),
            SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                    child: Text(
                      'Apply for Leave',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LeaveDetail extends StatelessWidget {
  final String title;
  final String value;

  const LeaveDetail({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
