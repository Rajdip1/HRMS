import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HRMS/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class UpdateRequestScreen extends StatefulWidget {
  const UpdateRequestScreen({super.key});

  @override
  State<UpdateRequestScreen> createState() => _UpdateRequestScreenState();
}

class _UpdateRequestScreenState extends State<UpdateRequestScreen> {

  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context); // Listen for theme changes

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

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: themeProvider.themeMode == ThemeMode.dark ? Colors.grey[800] : Colors.white,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Emp ID: ${data['userId']}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,
                        color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: updatedData.entries.map((entry) {
                            return Text("${entry.key}: ${entry.value}",style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,
                            color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),);
                          }).toList(),
                        ),
                      ),
                      Divider(thickness: 3,color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => DatabaseMethods().approveOrReject(request.id, true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Approve",
                              style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => DatabaseMethods().approveOrReject(request.id, false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                                "Reject",
                              style: TextStyle(color: themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                            ),
                          ),
                        ],
                      ),
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
}