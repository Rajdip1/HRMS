import 'package:flutter/material.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  State<ApplyLeaveScreen> createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final TextEditingController causeController = TextEditingController(text: 'Trip to Anand');
  final TextEditingController fromController = TextEditingController(text: 'Mon, 21 Dec 2025');
  final TextEditingController toController = TextEditingController(text: 'Wed, 23 Dec 2025');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedLeaveType = 'Casual Leave';
  final List<String> leaveTypes = ['Sick Leave', 'Annual Leave', 'Casual Leave'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply Leave'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(  // Move the Form here
          key: _formKey,
          child: Column(
            children: [
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
              EditableLeaveDetail(controller: causeController, label: 'Cause'),
              EditableLeaveDetail(controller: fromController, label: 'From'),
              EditableLeaveDetail(controller: toController, label: 'To'),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle leave application submission
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Leave Applied Successfully!'))
                        );
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
