import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrms/services/database.dart';
import 'package:random_string/random_string.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({super.key});

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {

  late String name,email,role,dept,phone,location;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController deptController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  addEmployeeData() async {
    String id = randomAlphaNumeric(6);

    Map<String,dynamic> employeeDataMap = {
      'Id': id,
      'Name': nameController.text,
      'Email': emailController.text,
      'Role': roleController.text,
      'Department': deptController.text,
      'Phone': phoneController.text,
      'Location': locationController.text
    };
    await DatabaseMethods().addEmployeeData(employeeDataMap, id).then((value) {
      Fluttertoast.showToast(
          msg: "Employee details has added successfully",
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
      appBar: AppBar(title: Text('Add new data',style: TextStyle(color: Colors.red,fontSize: 24.0,fontWeight: FontWeight.bold),),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(border: InputBorder.none,),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Text('Email',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(border: InputBorder.none,),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Text('Role',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: roleController,
                    decoration: InputDecoration(border: InputBorder.none,),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your role';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Text('Department',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: deptController,
                    decoration: InputDecoration(border: InputBorder.none,),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your department';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Text('Phone',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(border: InputBorder.none,),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
                Text('Location',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(border: InputBorder.none,),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30.0,),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        setState(() {
                          name = nameController.text;
                          email = emailController.text;
                          role = roleController.text;
                          dept = deptController.text;
                          phone = phoneController.text;
                          location = locationController.text;
                        });
                        addEmployeeData();
                      }
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],),
          ),),
      ),
    );
  }
}
