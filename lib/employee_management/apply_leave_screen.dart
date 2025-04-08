import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the date and time

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController causeController = TextEditingController(text: '');
  final TextEditingController fromController = TextEditingController(text: '');
  final TextEditingController toController = TextEditingController(text: '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedLeaveType = 'Casual Leave';
  final List<String> leaveTypes = ['Sick Leave', 'Annual Leave', 'Casual Leave', 'Half Leave'];

  final user = FirebaseAuth.instance.currentUser;

  applyLeave() async {
    await FirebaseFirestore.instance.collection("leave_requests").add({
      'EmployeeName': nameController.text,
      'EmployeeEmail': user?.email ?? 'No Email',  //for identification
      'Leave Type': selectedLeaveType,
      'Cause': causeController.text,
      'From': fromController.text,
      'To': toController.text,
      'Status': 'pending',
      'time stamp': FieldValue.serverTimestamp()
    });


    //cleat the form after clicking button
    nameController.clear();
    causeController.clear();
    fromController.clear();
    toController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Leave Applied Successfully!')),
    );
  }

  Future<void> selectDateTime(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        String formatted = DateFormat('yyyy-MM-dd HH:mm').format(finalDateTime);
        controller.text = formatted;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              EditableLeaveDetail(controller: nameController, label: 'Name'),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: selectedLeaveType,
                decoration: const InputDecoration(
                  labelText: 'Type',
                  border: OutlineInputBorder(),
                ),
                items: leaveTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLeaveType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 5),
              EditableLeaveDetail(controller: causeController, label: 'Cause'),
              const SizedBox(height: 5),


              // FROM date-time picker
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: fromController,
                  readOnly: true,
                  onTap: () => selectDateTime(fromController),
                  decoration: const InputDecoration(
                    labelText: 'From',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today), // Added icon here
                  ),
                ),
              ),

              // TO date-time picker
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: toController,
                  readOnly: true,
                  onTap: () => selectDateTime(toController),
                  decoration: const InputDecoration(
                    labelText: 'To',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today), // Added icon here
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        applyLeave();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Apply for Leave',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditableLeaveDetail extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const EditableLeaveDetail({super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
        ),
    );
  }
}