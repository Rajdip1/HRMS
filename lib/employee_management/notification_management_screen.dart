import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationManagementScreen extends StatefulWidget {
  const NotificationManagementScreen({super.key});

  @override
  State<NotificationManagementScreen> createState() => _NotificationManagementScreenState();
}

class _NotificationManagementScreenState extends State<NotificationManagementScreen> {
  final String? currentUserEmail =FirebaseAuth.instance.currentUser?.email;  //logged in user


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications'),),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("leave_requests").where('EmployeeEmail', isEqualTo: currentUserEmail)
         .snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final requests = snapshot.data!.docs;

            if(requests.isEmpty) {
              return Center(child: Text('No request has found'));
            }

            return ListView.builder(
              itemCount: requests.length,
                itemBuilder: (context, index) {
                  var data = requests[index].data() as Map<String, dynamic>;
                  String docId = requests[index].id;

                  String status = data['status'] ?? 'pending';
                  String leaveType = data['Leave Type'] ?? '';
                  Timestamp? timeStamp = data['time stamp'];

                  Color statusColor = (status=='Approved') ? Colors.green : (status=='Rejected') ? Colors.red : Colors.orange;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: ListTile(
                      title: Text("Leave Type: $leaveType"),
                      subtitle: Text("Applied on: ${timeStamp?.toDate().toLocal() ?? 'Unknown'}"),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
