import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class EmployeeEditDetailsForm extends StatefulWidget {
  const EmployeeEditDetailsForm({super.key, required this.empId});

  @override
  State<EmployeeEditDetailsForm> createState() => _EmployeeEditDetailsFormState();
  final String empId;
}

class _EmployeeEditDetailsFormState extends State<EmployeeEditDetailsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController dateOfBirthController = new TextEditingController();
  final TextEditingController branchController = new TextEditingController();
  final TextEditingController departmentController = new TextEditingController();
  final TextEditingController supervisorController = new TextEditingController();
  final TextEditingController empTypeController = new TextEditingController();
  final TextEditingController joiningDateController = new TextEditingController();
  final TextEditingController officeTimeController = new TextEditingController();
  final TextEditingController bankNameController = new TextEditingController();
  final TextEditingController bankAccNumController = new TextEditingController();
  final TextEditingController bankAccHolderNameController = new TextEditingController();
  final TextEditingController bankAccTypeController = new TextEditingController();

  // values for dropdown
  String selectGender = 'Male';
  String selectMaritaleStatus = 'Single';

  @override
  void initState() {
    super.initState();
    fetchEmpData();
  }
  // get filled form when user open edit form for data update
  Future<void> fetchEmpData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc(userId).get();

    if(snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      setState(() {
        nameController.text = data['Name'] ?? '';
        addressController.text = data['Address'] ?? '';
        emailController.text = data['Email'] ?? '';
        phoneController.text = data['Phone'] ?? '';
        dateOfBirthController.text = data['Date of Birth'] ?? '';
        selectGender = data['Gender'] ?? 'Male';
        selectMaritaleStatus = data['Marital Status'] ?? 'Single';
        branchController.text = data['Branch'] ?? '';
        departmentController.text = data['Department'] ?? '';
        supervisorController.text = data['Supervisor'] ?? '';
        empTypeController.text = data['Employment Type'] ?? '';
        joiningDateController.text = data['Joining Date'] ?? '';
        officeTimeController.text = data['Office Time'] ?? '';
        bankNameController.text = data['Bank Name'] ?? '';
        bankAccNumController.text = data['Bank Account Number'] ?? '';
        bankAccHolderNameController.text = data['Account Holder Name'] ?? '';
        bankAccTypeController.text = data['Bank Account Type'] ?? '';
      });
    }
  }

  Future<void> updateRequest() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> updateData = {
      'Name': nameController.text,
      'Address': addressController.text,
      'Email': emailController.text,
      'Phone': phoneController.text,
      'Date of Birth': dateOfBirthController.text,
      'Gender': selectGender,
      'Marital Status': selectMaritaleStatus,
      'Branch': branchController.text,
      'Department': departmentController.text,
      'Supervisor': supervisorController.text,
      'Employment Type': empTypeController.text,
      'Joining Date': joiningDateController.text,
      'Office Time': officeTimeController.text,
      'Bank Name': bankNameController.text,
      'Bank Account Number': bankAccNumController.text,
      'Account Holder Name': bankAccHolderNameController.text,
      'Bank Account Type': bankAccTypeController.text
    };
    await FirebaseFirestore.instance.collection("requests").add({
      'userId': userId,
      'updateData': updateData,
      'status': 'pending',
      'rewuestedAt': FieldValue.serverTimestamp()
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Update request sent to HR")),
    );
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Listen for theme changes
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle("Personal Detail",isDarkMode),
              buildTextField("Name",nameController,'Enter your name',isDarkMode),
              buildTextField("Address", addressController,'Enter your address',isDarkMode),
              buildTextField("Email", emailController,'Enter your email',isDarkMode),
              buildTextField("Phone No", phoneController,'Enter your phone number',isDarkMode),
              buildTextField("Date of Birth", dateOfBirthController,'Enter your date of birth',isDarkMode),
              SizedBox(height: 10),
              buildDropdownField("Gender", ['Male','Female','Other'],selectGender, isDarkMode,
                  (newVal) {
                setState(() {
                  selectGender = newVal!;
                });
              }),
              SizedBox(height: 10),
              buildDropdownField("Marital Status", ['Single','Married'],selectMaritaleStatus, isDarkMode,
                  (newVal) {
                setState(() {
                  selectMaritaleStatus = newVal!;
                });
                  }),
              SizedBox(height: 10),
              buildSectionTitle("Company Detail",isDarkMode),
              buildTextField("Department", departmentController,'Enter your department',isDarkMode),
              buildTextField("Supervisor", supervisorController,'Enter your supervisor',isDarkMode),
              buildTextField("Employment Type", empTypeController,'Enter your employment type',isDarkMode),
              buildTextField("Joining Date", joiningDateController,'Enter your date of joining',isDarkMode),
              buildTextField("Office Time", officeTimeController,'Enter your office come time',isDarkMode),
              SizedBox(height: 10),

              buildSectionTitle("Bank Detail",isDarkMode),
              buildTextField("Bank Name", bankNameController,'Enter your bank name',isDarkMode),
              buildTextField("Bank Account Number", bankAccNumController,'Enter your bank account number',isDarkMode),
              buildTextField("Account Holder Name", bankAccHolderNameController,'Enter account holder name',isDarkMode),
              buildTextField("Bank Account Type", bankAccTypeController,'Enter account type',isDarkMode),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          // add();
                          updateRequest();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
                        foregroundColor: isDarkMode ? Colors.white : Colors.black, // Change text color
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Submit"),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  //   child: Text("Add User"),
                  // ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, String errorMessage, bool isDarkMode) {
    bool isDateField = label == "Date of Birth";
    bool isTimeField = label == "Office Time";

    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        controller: controller,
        readOnly: isDateField || isTimeField,
        validator: (val) => val!.isEmpty ? errorMessage : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
          border: OutlineInputBorder(),
          suffixIcon: isDateField || isTimeField
              ? Icon(
            isDateField ? Icons.calendar_today : Icons.access_time,
            color: isDarkMode ? Colors.white : Colors.black,
          )
              : null,
        ),
        onTap: () async {
          if (isDateField) {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              controller.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
            }
          } else if (isTimeField) {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return Theme(
                  data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
                  child: child!,
                );
              },
            );
            if (pickedTime != null) {
              controller.text = pickedTime.format(context);
            }
          }
        },
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> option, String selectedValue,bool isDarkMode, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        items: option.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
