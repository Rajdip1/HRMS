import 'package:HRMS/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveRequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Requests')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('leave_requests')
            .orderBy('time stamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final requests = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              String docId = request.id;
              Map<String, dynamic> data = request.data() as Map<String, dynamic>;

              // Ensure status is not null
              String status = (data['status'] ?? 'pending').toString();

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person,size: 40,),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            data['EmployeeName'] ?? 'EmployeeName',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              if(value == 'delete') {
                                await DatabaseMethods().deleteLeaveRequest(docId);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Deleted Successfully")),
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(value: "delete", child: Text("Delete"),)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text("Applied on: ${data['time stamp']?.toDate().toLocal()}"),
                      Text("Leave Type: ${data['Leave Type']}"),
                      Text("From: ${data['From']}"),
                      Text("To: ${data['To']}"),
                      Text("Cause: ${data['Cause']}"),
                      const SizedBox(height: 12),
                      Text(
                        "Status: $status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: (status == 'Approved')
                              ? Colors.green
                              : (status == 'Rejected')
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                      if (status == 'pending') ...[
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  _showConfirmationDialog(context, docId, 'Approved'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text("Approve"),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  _showConfirmationDialog(context, docId, 'Rejected'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text("Reject"),
                            ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Show confirmation dialog
  void _showConfirmationDialog(BuildContext context, String docId, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm $status"),
          content: Text("Are you sure you want to $status this leave request?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                _updateLeaveStatus(docId, status);
                Navigator.of(context).pop(); // Close the dialog after updating
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  // this will changing in firebase db
  void _updateLeaveStatus(String docId, String status) {
    FirebaseFirestore.instance.collection('leave_requests').doc(docId).update({
      'status': status,
      'Status': FieldValue.delete(),
    });
  }
}
