import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //Add employee data
  Future addEmployeeData(
      Map<String, dynamic> employeeDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('employees')
        .doc(id)
        .set(employeeDataMap);
  }

  //get employee details
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection('employees').snapshots();
  }

  //update data
  Future updateEmployeeData(String id, Map<String, dynamic> updateData) async {
    return await FirebaseFirestore.instance
        .collection('employees')
        .doc(id)
        .update(updateData);
  }

  //delete employee data
  Future deleteEmployeeData(String id) async {
    return await FirebaseFirestore.instance
        .collection('employees')
        .doc(id)
        .delete();
  }
}
