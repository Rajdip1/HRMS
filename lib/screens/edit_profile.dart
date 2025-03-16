import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionTitle("Personal Detail"),
            buildTextField("Name", "Admin"),
            buildTextField("Address", "Kathmandu, Nepal"),
            buildTextField("Email", "admin@admin.com"),
            buildTextField("Phone No", "9811111111"),
            buildTextField("Date of Birth", "09-05-1995"),
            SizedBox(height: 10),
            buildDropdownField("Gender", "Male"),
            SizedBox(height: 10),
            buildDropdownField("Marital Status", "Single"),
            SizedBox(height: 10),
            buildSectionTitle("Company Detail"),
            buildTextField("Branch", "LAANTA FULINTA"),
            buildTextField("Department", "Madaxa (Media)"),
            buildTextField("Supervisor", "Admin"),
            buildTextField("Employment Type", "Contract"),
            buildTextField("Joining Date", "29-09-2022"),
            buildTextField("Office Time", "10:00 AM - 7:00 PM"),
            SizedBox(height: 10),
            // buildSectionTitle("Leave Detail"),
            // buildTextField("Leave Allocated", "12"),
            // buildTextField("Sick Leave", "1"),
            // buildTextField("Paid Leave", "1"),
            // buildTextField("Urgent Leave", "1"),
            // buildTextField("Unpaid Leave", "1"),
            // buildTextField("Annual Leave", "1"),
            // SizedBox(height: 10),
            buildSectionTitle("Bank Detail"),
            buildTextField("Bank Name", "ABC Bank"),
            buildTextField("Bank Account Number", "067800054570"),
            buildTextField("Account Holder Name", "Admin"),
            buildTextField("Bank Account Type", "Salary"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text("Update Details"),
                ),
                // ElevatedButton(
                //   onPressed: () {},
                //   style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                //   child: Text("Add User"),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildTextField(String label, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        dropdownColor: Colors.white,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        items: [value].map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: (newValue) {},
      ),
    );
  }
}
