import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Add employee data
  Future addEmployeeData(
      Map<String, dynamic> employeeDataMap, String id) async {
    return await _firestore
        .collection('employees')
        .doc(id) //particular document id
        .set(employeeDataMap);
  }

  //Read data from database
  Stream<DocumentSnapshot<Map<String, dynamic>>> getEmployeeDetails(String userId) {
    return FirebaseFirestore.instance.collection("employees").doc(userId).snapshots();
  }
}
