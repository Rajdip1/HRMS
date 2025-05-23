import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  List<Map<String, dynamic>> departments = [
    {"id": 1, "name": "IT", "head": "Mayur Sharma", "employees": 3, "address": "A Block", "phone": "2237466598", "status": true},
    {"id": 2, "name": "Finance", "head": "Shruti Patel", "employees": 4, "address": "B Block", "phone": "9225045625", "status": true},
    {"id": 3, "name": "Marketing", "head": "Kashish Gupta", "employees": 5, "address": "C Block", "phone": "8209126381", "status": true},
    {"id": 3, "name": "HR", "head": "Jinal Patel", "employees": 4, "address": "A Block", "phone": "8209126381", "status": true},
  ];

  void _deleteDepartment(int index) {
    setState(() {
      departments.removeAt(index);
    });
  }

  void _editDepartment(int index) async {
    final updatedDepartment = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDepartmentScreen(department: departments[index]),
      ),
    );
    if (updatedDepartment != null) {
      setState(() {
        departments[index] = updatedDepartment;
      });
    }
  }

  void _addDepartment() async {
    final newDepartment = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDepartmentScreen(department: null)),
    );
    if (newDepartment != null) {
      setState(() {
        departments.add(newDepartment);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Department Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addDepartment,
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: departments.length,
        itemBuilder: (context, index) {
          return DepartmentCard(
            department: departments[index],
            onEdit: () => _editDepartment(index),
            onDelete: () => _deleteDepartment(index),
          );
        },
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final Map<String, dynamic> department;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const DepartmentCard({
    required this.department,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(department['name'] ?? 'Unknown', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Head: ${department['head'] ?? 'N/A'} | Employees: ${department['employees'] ?? 0}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: onEdit),
            IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}

class EditDepartmentScreen extends StatefulWidget {
  final Map<String, dynamic>? department;

  const EditDepartmentScreen({super.key, this.department});

  @override
  _EditDepartmentScreenState createState() => _EditDepartmentScreenState();
}

class _EditDepartmentScreenState extends State<EditDepartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController headController;
  late TextEditingController employeesController;
  late TextEditingController addressController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.department?['name'] ?? '');
    headController = TextEditingController(text: widget.department?['head'] ?? '');
    employeesController = TextEditingController(text: widget.department?['employees']?.toString() ?? '');
    addressController = TextEditingController(text: widget.department?['address'] ?? '');
    phoneController = TextEditingController(text: widget.department?['phone'] ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    headController.dispose();
    employeesController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _saveDepartment() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'id': widget.department?['id'] ?? DateTime.now().millisecondsSinceEpoch,
        'name': nameController.text,
        'head': headController.text,
        'employees': int.tryParse(employeesController.text) ?? 0,
        'address': addressController.text,
        'phone': phoneController.text,
        'status': widget.department?['status'] ?? true,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.department == null ? "Add Department" : "Edit Department")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: nameController, decoration: InputDecoration(labelText: "Name"), validator: (value) => value!.isEmpty ? "Enter name" : null),
              TextFormField(controller: headController, decoration: InputDecoration(labelText: "Head")),
              TextFormField(controller: employeesController, decoration: InputDecoration(labelText: "Employees"), keyboardType: TextInputType.number),
              TextFormField(controller: addressController, decoration: InputDecoration(labelText: "Address")),
              TextFormField(controller: phoneController, decoration: InputDecoration(labelText: "Phone")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveDepartment, child: Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
