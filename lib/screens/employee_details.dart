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

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController deptController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

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
      appBar: AppBar(title: Text('Add new data',style: TextStyle(color: Colors.blue,fontSize: 24.0,fontWeight: FontWeight.bold),),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0,top: 30.0,right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(border: InputBorder.none,),
                ),
              ),
              SizedBox(height: 20,),
              Text('Email',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(border: InputBorder.none,),
                ),
              ),
              SizedBox(height: 20,),
              Text('Role',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: roleController,
                  decoration: InputDecoration(border: InputBorder.none,),
                ),
              ),
              SizedBox(height: 20,),
              Text('Department',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: deptController,
                  decoration: InputDecoration(border: InputBorder.none,),
                ),
              ),
              SizedBox(height: 20,),
              Text('Phone',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(border: InputBorder.none,),
                ),
              ),
              SizedBox(height: 20.0,),
              Text('Location',style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(border: InputBorder.none,),
                ),
              ),
              SizedBox(height: 30.0,),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addEmployeeData();
                  },
                  child: Text(
                    'Add Employee',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],),),
      ),
    );
  }
}
