// import 'package:flutter/material.dart';
//
// import 'leave_request_screen.dart';
//
// class LeaveRejectedScreen extends StatelessWidget {
//   final List<LeaveRequest> leaveRequests;
//
//   const LeaveRejectedScreen({super.key, required this.leaveRequests});
//
//   @override
//   Widget build(BuildContext context) {
//     List<LeaveRequest> rejectedRequests = leaveRequests.where((req) => req.status == "rejected").toList();
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Rejected Leave Requests")),
//       body: rejectedRequests.isEmpty
//           ? Center(child: Text("No rejected leave requests"))
//           : ListView.builder(
//         itemCount: rejectedRequests.length,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text(rejectedRequests[index].name),
//               subtitle: Text("Rejected on: ${rejectedRequests[index].appliedDate}"),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
