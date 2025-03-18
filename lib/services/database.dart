import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  //Update employee data
  Future<void> addEmployeeData(Map<String, dynamic> employeeDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id) // Update the same document
        .update(employeeDataMap) // Merge new data with existing fields
        .then((_) => print("Employee data added successfully"))
        .catchError((error) => print("Failed to add employee data: $error"));
  }



  //Read data from database
  Stream<DocumentSnapshot> getEmployeeDetails(String id) {
    return userCollection.doc(id).snapshots();
  }

  //Read on HR side
  Stream<QuerySnapshot> getAllEmployeeDetails() {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  //delete from HR side
  Future deleteEmployeeDetails(String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).delete();
  }
}
