import 'package:flutter/material.dart';
import 'leave_request_screen.dart';


class LeaveApprovalScreen extends StatelessWidget {
  final List<LeaveRequest> leaveRequests;

  const LeaveApprovalScreen({super.key, required this.leaveRequests});

  @override
  Widget build(BuildContext context) {
    List<LeaveRequest> approvedRequests = leaveRequests.where((req) => req.status == "approved").toList();

    return Scaffold(
      appBar: AppBar(title: Text("Approved Leave Requests")),
      body: approvedRequests.isEmpty
          ? Center(child: Text("No approved leave requests"))
          : ListView.builder(
        itemCount: approvedRequests.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(approvedRequests[index].name),
              subtitle: Text("Approved on: ${approvedRequests[index].appliedDate}"),
            ),
          );
        },
      ),
    );
  }
}
