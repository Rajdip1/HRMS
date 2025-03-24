import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  //pending req for HR to approve
  Stream<QuerySnapshot> getPendingReq() {
    return FirebaseFirestore.instance.collection("requests").where('status', isEqualTo: 'pending').snapshots();
  }

  Future<void> approveOrReject(String requestId, bool isApproved) async {
    print("Button clicked! Request ID: $requestId, isApproved: $isApproved");

    DocumentReference requestRef = FirebaseFirestore.instance.collection('requests').doc(requestId);

    DocumentSnapshot requestSnap = await requestRef.get();

    if (requestSnap.exists) {
      Map<String, dynamic>? requestData = requestSnap.data() as Map<String, dynamic>?;

      if (requestData != null && requestData.containsKey('userId') && requestData.containsKey('updateData')) {
        String userId = requestData['userId'];
        Map<String, dynamic> updatedData = Map<String, dynamic>.from(requestData['updateData']);

        // print("Processing request for userId: $userId");

        if (isApproved) {
          // Update user data in 'users' collection
          await FirebaseFirestore.instance.collection('users').doc(userId).update(updatedData);
          await requestRef.update({"status": "approved"});
          // print("Request approved and user data updated.");
        } else {
          await requestRef.update({"status": "rejected"});
          // print("Request rejected.");
        }
      } else {
        print("Error: requestData is null or missing required fields.");
      }
    } else {
      print("Error: Document does not exist.");
    }
  }
}
