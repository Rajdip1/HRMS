import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrms/screens/employee_details.dart';
import 'package:hrms/services/database.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController deptController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  String id = '';

  Stream? EmployeeDataStream;

  //load data function
  loadEmployeeData() async {
    EmployeeDataStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {

    });
  }

  @override
  void initState() {
    loadEmployeeData();
    super.initState();
  }

  //update data func
  updateData() async {
    Map<String,dynamic> updateDataMap = {
      'Id': id,
      'Name': nameController.text,
      'Email': emailController.text,
      'Role': roleController.text,
      'Department': deptController.text,
      'Phone': phoneController.text,
      'Location': locationController.text
    };
    await DatabaseMethods().updateEmployeeData(id, updateDataMap).then((value) {
      Navigator.pop(context);
    });
  }

  //widget function
  Widget listOfEmployeeData() {
    return StreamBuilder(
        stream: EmployeeDataStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name : '+ ds['Name'],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        id = ds['Id'];
                                      });
                                      nameController.text = ds['Name'];
                                      emailController.text = ds['Email'];
                                      roleController.text = ds['Role'];
                                      deptController.text = ds['Department'];
                                      phoneController.text = ds['Phone'];
                                      locationController.text = ds['Location'];
                                      editEmployeeData(id);
                                    },
                                      child: Icon(Icons.edit)
                                  ),
                                  SizedBox(height: 10.0,),
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        id = ds['Id'];
                                      });
                                      await DatabaseMethods().deleteEmployeeData(id);
                                    },
                                      child: Icon(Icons.delete)
                                  )
                                ],
                              ),

                              Text(
                                'Email : '+ ds['Email'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Role : '+ ds['Role'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Department : '+ ds['Department'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Phone : '+ ds['Phone'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Location : '+ ds['Location'],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EmployeeDetails()));
        },
        child: Icon(Icons.add,size: 45.0,),
      ),
      appBar: AppBar(
        title: Text(
          'Admin Profile',
          style: TextStyle(
              color: Colors.blue, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(Icons.logout_outlined)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: listOfEmployeeData())
          ],
        ),
      ),
    );
  }

  Future editEmployeeData(String id) => showDialog(context: context, builder: (context) => AlertDialog(
    content: SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.cancel,size: 40,)
                ),
                SizedBox(width: 60.0,),
                Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Data',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Text('Name',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0,),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: InputBorder.none,),
              ),
            ),
            SizedBox(height: 20.0,),
            Text('Email',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
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
            Text('Role',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
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
            Text('Location',style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
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
                  //func called
                  updateData();
                },
                child: Text(
                  'Update',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  ));

}
