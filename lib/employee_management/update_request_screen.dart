import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HRMS/services/database.dart';
import 'package:flutter/material.dart';

class UpdateRequestScreen extends StatefulWidget {
  const UpdateRequestScreen({super.key});

  @override
  State<UpdateRequestScreen> createState() => _UpdateRequestScreenState();
}

class _UpdateRequestScreenState extends State<UpdateRequestScreen> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Approve Requests")),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseMethods().getPendingReq(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // print("No pending requests found");
            return Center(child: Text("No pending requests"));
          }

          var requests = snapshot.data!.docs;
          // print("Pending Requests Count: ${requests.length}");

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index];
              var data = request.data() as Map<String, dynamic>?;

              if (data == null || !data.containsKey('updateData') || !data.containsKey('userId')) {
                // print("Invalid request data: $data");
                return SizedBox();
              }

              var updatedData = Map<String, dynamic>.from(data['updateData']);  // Corrected key

              // print("Displaying request for userId: ${data['userId']}");

              return Card(
                color: Colors.blue[100],
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Emp ID: ${data['userId']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: updatedData.entries.map((entry) {
                          return Text("${entry.key}: ${entry.value}",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),);
                        }).toList(),
                      ),
                    ),
                    Divider(thickness: 2,color: Colors.black,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () => DatabaseMethods().approveOrReject(request.id, true),
                          icon: Icon(Icons.check,color: Colors.green,size: 40,),
                          label: Text('Approve',style: TextStyle(fontSize: 25),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Adjust radius as needed
                            ),
                          ),
                        ),
                        // Horizontal Line
                        Container(
                          height: 40, // Adjust height as needed
                          width: 2, // Thickness of the line
                          color: Colors.grey, // Line color
                        ),
                        TextButton.icon(
                          onPressed: () => DatabaseMethods().approveOrReject(request.id, false),
                          icon: Icon(Icons.close,color: Colors.red,size: 40,),
                          label: Text('Reject',style: TextStyle(fontSize: 25),),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Same radius for consistency
                            ),
                          ),
                        )

                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),


    );
  }
}