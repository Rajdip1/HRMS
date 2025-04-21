import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeDetailsCard extends StatefulWidget {
  final String empId;
  const EmployeeDetailsCard({super.key, required this.empId});

  @override
  State<EmployeeDetailsCard> createState() => _EmployeeDetailsCardState();
}

class _EmployeeDetailsCardState extends State<EmployeeDetailsCard> {
  Future<DocumentSnapshot> getEmpDetails(String empId) async {
    return FirebaseFirestore.instance.collection("users").doc(empId).get();
  }

  // void _launchEmail(String email) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //   );
  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Could not launch email app')),
  //     );
  //   }
  // }

  void _launchCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if(await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch call app')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Profile')),
      body: FutureBuilder<DocumentSnapshot>(
        future: getEmpDetails(widget.empId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("Employee not found"));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          final name = data['Name'] ?? 'N/A';
          final email = data['Email'] ?? 'N/A';
          final role = data['role'] ?? 'N/A';
          final department = data['Department'] ?? 'N/A';
          final phone = data['Phone'] ?? 'N/A';
          final gender = data['Gender'] ?? 'N/A';
          final employmentType = data['Employment Type'] ?? 'N/A';
          final joiningDate = data['Joining Date'] ?? 'N/A';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blueGrey.shade100,
                        child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 16),
                      Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                      Divider(height: 32, thickness: 1),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text("Email"),
                        subtitle: Text(email),
                      ),
                      ListTile(
                        leading: Icon(Icons.badge),
                        title: Text("Role"),
                        subtitle: Text(role),
                      ),
                      ListTile(
                        leading: Icon(Icons.apartment),
                        title: Text("Department"),
                        subtitle: Text(department),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Phone"),
                        subtitle: Text(phone),
                      ),
                      ListTile(
                        leading: Icon(Icons.co_present_sharp),
                        title: Text("Employment Type"),
                        subtitle: Text(employmentType),
                      ),
                      ListTile(
                        leading: Icon(Icons.date_range),
                        title: Text("Joined Date"),
                        subtitle: Text(joiningDate),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // ElevatedButton.icon(
                          //   onPressed: () => _launchEmail(email),
                          //   icon: Icon(Icons.email),
                          //   label: Text("Contact"),
                          //   style: ElevatedButton.styleFrom(
                          //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     backgroundColor: Colors.blue,
                          //   ),
                          // ),
                          // Spacer(),
                          ElevatedButton.icon(
                              onPressed: () => _launchCall(phone),
                            icon: Icon(Icons.phone),
                            label: Text(" Call     "),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.blue,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
