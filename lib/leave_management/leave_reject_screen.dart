import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaveRejectScreen extends StatelessWidget {
  const LeaveRejectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rejected Leave Requests'),),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("leave_requests").where('status', isEqualTo: 'Rejected').snapshots(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final rejectedReq = snapshot.data!.docs;

            if (rejectedReq.isEmpty) {
              return const Center(child: Text("No rejected leave requests"));
            }

            return ListView.builder(
              itemCount: rejectedReq.length,
                itemBuilder: (context, index) {
                var data = rejectedReq[index].data() as Map<String, dynamic>;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: ListTile(
                      title: Text(data['EmployeeName'] ?? "Unknown"),
                      subtitle: Text("Rejected on: ${data['time stamp']?.toDate().toLocal()}"),
                    ),
                  );

                }
            );
          }
      ),
    );
  }
}
