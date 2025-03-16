import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CompanyProfilePage extends StatefulWidget {
  @override
  _CompanyProfilePageState createState() => _CompanyProfilePageState();
}
class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final TextEditingController companyNameController =
  TextEditingController(text: "Humancapital");
  final TextEditingController companyOwnerController =
  TextEditingController(text: "Humancapital Info Tech");
  final TextEditingController addressController =
  TextEditingController(text: "Gujarat");
  final TextEditingController emailController =
  TextEditingController(text: "info@humancapital.com");
  final TextEditingController phoneController =
  TextEditingController(text: "9841000000");
  final TextEditingController websiteController =
  TextEditingController(text: "https://www.humancapital.com");

  List<String> officeDays = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  Map<String, bool> selectedDays = {};
  String? selectedFileName;

  @override
  void initState() {
    super.initState();
    for (var day in officeDays) {
      selectedDays[day] = false;
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

  void updateCompany() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Company updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Company Profile"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField("Company Name", companyNameController),
            buildTextField("Company Owner", companyOwnerController),
            buildTextField("Address", addressController),
            buildTextField("Email Address", emailController),
            buildTextField("Phone No", phoneController),
            buildTextField("Website URL", websiteController),
            SizedBox(height: 10),
            Text("Check Office Off Days",
                style: TextStyle(color: Colors.white)),
            Column(
              children: officeDays.map((day) {
                return CheckboxListTile(
                  title: Text(day, style: TextStyle(color: Colors.white)),
                  value: selectedDays[day],
                  activeColor: Colors.black12,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedDays[day] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text("Upload Logo", style: TextStyle(color: Colors.white)),
            Row(
              children: [
                ElevatedButton(
                  onPressed: pickFile,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12),
                  child: Text("Choose File"),
                ),
                SizedBox(width: 10),
                Text(
                  selectedFileName ?? "No file chosen",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateCompany,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white),
                child: Text("Update Company", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Color(0xFF1E1E2C),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
