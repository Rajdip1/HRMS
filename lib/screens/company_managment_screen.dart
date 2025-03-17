import 'package:flutter/material.dart';
import 'company_profile.dart';

class CompanyManagementScreen extends StatelessWidget {
  const CompanyManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Company Management"),
        backgroundColor: Color(0xFF1E1E2C),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            tileColor: Color(0xFF1E1E2C),
            title: Text("Company", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.business, color: Colors.white),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompanyProfilePage()),
              );
            },
          ),
          SizedBox(height: 10),
          ListTile(
            tileColor: Color(0xFF1E1E2C),
            title: Text("Branch", style: TextStyle(color: Colors.white)),
            leading: Icon(Icons.apartment, color: Colors.white),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.white70),
            onTap: () {
              // Navigate to branch screen (To be implemented)
            },
          ),
        ],
      ),
    );
  }
}
