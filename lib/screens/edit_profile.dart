import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

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

  //function for add data
  add() async {
    String id = randomAlphaNumeric(10);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String,dynamic> employeeInfoMap = {
      'id': id,
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
    await DatabaseMethods().addEmployeeData(employeeInfoMap, userId).then((value) {
      Fluttertoast.showToast(
          msg: "Your details has added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle("Personal Detail"),
              buildTextField("Name",nameController,'Enter your name'),
              buildTextField("Address", addressController,'Enter your address'),
              buildTextField("Email", emailController,'Enter your email'),
              buildTextField("Phone No", phoneController,'Enter your phone number'),
              buildTextField("Date of Birth", dateOfBirthController,'Enter your date of birth'),
              SizedBox(height: 10),
              buildDropdownField("Gender", ['Male','Female','Other'],selectGender,
                      (newVal) {
                    setState(() {
                      selectGender = newVal!;
                    });
                  }),
              SizedBox(height: 10),
              buildDropdownField("Marital Status", ['Single','Married'],selectMaritaleStatus,
                      (newVal) {
                    setState(() {
                      selectMaritaleStatus = newVal!;
                    });
                  }),
              SizedBox(height: 10),
              buildSectionTitle("Company Detail"),
              buildTextField("Branch", branchController,'Enter your branch'),
              buildTextField("Department", departmentController,'Enter your department'),
              buildTextField("Supervisor", supervisorController,'Enter your supervisor'),
              buildTextField("Employment Type", empTypeController,'Enter your employment type'),
              buildTextField("Joining Date", joiningDateController,'Enter your date of joining'),
              buildTextField("Office Time", officeTimeController,'Enter your office come time'),
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
              buildTextField("Bank Name", bankNameController,'Enter your bank name'),
              buildTextField("Bank Account Number", bankAccNumController,'Enter your bank account number'),
              buildTextField("Account Holder Name", bankAccHolderNameController,'Enter account holder name'),
              buildTextField("Bank Account Type", bankAccTypeController,'Enter account type'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        add();
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text("Edit Data"),
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

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        validator: (val) {
          if(val==null || val.isEmpty) {
            return errorMessage;
          }
          return null;
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField(String label, List<String> option, String selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
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
        items: option.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item, style: TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
