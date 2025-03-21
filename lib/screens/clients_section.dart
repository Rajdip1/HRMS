import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef Client = Map<String, String>;

class ProjectManagementClient extends StatelessWidget {
  const ProjectManagementClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClientsScreen(),
    );
  }
}

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  List<Client> clients = [
    {
      'name': 'Kartik Mishra',
      'email': 'Kartik12@gmail.com',
      'phone': '9279405972',
      'country': 'India',
      'branch': 'Jaipur',
      'status': 'Active'
    },
    {
      'name': 'Mayur Panchal',
      'email': 'Mayur6@yahoo.com',
      'phone': '8569475660',
      'country': 'India',
      'branch': 'Mumbai',
      'status': 'Inactive'
    },
    {
      'name': 'Apurva Devol',
      'email': 'ap67@gmail.com',
      'phone': '9745867782',
      'country': 'India',
      'branch': 'Baroda',
      'status': 'Active'
    },
  ];

  void deleteClient(int index) {
    setState(() {
      clients.removeAt(index);
    });
  }

  void addClient(Client newClient) {
    setState(() {
      clients.add(newClient);
    });
  }

  void editClient(int index, Client updatedClient) {
    setState(() {
      clients[index] = updatedClient;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateClientScreen(
                  onSave: (newClient) {
                    addClient(newClient);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(clients[index]['name']!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${clients[index]['email']}'),
                  Text('Phone: ${clients[index]['phone']}'),
                  Text('Status: ${clients[index]['status']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditClientScreen(
                          client: clients[index],
                          onSave: (updatedClient) {
                            editClient(index, updatedClient);
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteClient(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Screen to create a new client manually
class CreateClientScreen extends StatefulWidget {
  final Function(Client) onSave;

  const CreateClientScreen({super.key, required this.onSave});

  @override
  _CreateClientScreenState createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends State<CreateClientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? profileImagePath;

  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Client')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Client Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
            TextField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Country')),
            TextField(
                controller: branchController,
                decoration: InputDecoration(labelText: 'Branch')),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address')),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickProfileImage,
              icon: Icon(Icons.upload),
              label: Text('Upload Profile Picture'),
            ),
            if (profileImagePath != null && profileImagePath!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(profileImagePath!, height: 100),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave({
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'country': countryController.text,
                  'branch': branchController.text,
                  'address': addressController.text,
                  'status': 'Active',
                  'profileImage': profileImagePath ?? '',
                });
                Navigator.pop(context);
              },
              child: Text('Add Client'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditClientScreen extends StatefulWidget {
  final Client client;
  final Function(Client) onSave;

  const EditClientScreen(
      {super.key, required this.client, required this.onSave});

  @override
  _EditClientScreenState createState() => _EditClientScreenState();
}

class _EditClientScreenState extends State<EditClientScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController countryController;
  late TextEditingController branchController;
  late TextEditingController addressController;
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.client['name']);
    emailController = TextEditingController(text: widget.client['email']);
    phoneController = TextEditingController(text: widget.client['phone']);
    countryController =
        TextEditingController(text: widget.client['country'] ?? '');
    branchController =
        TextEditingController(text: widget.client['branch'] ?? '');
    addressController =
        TextEditingController(text: widget.client['address'] ?? '');
    profileImagePath = widget.client['profileImage'] ?? '';
  }

  Future<void> pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        profileImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Client')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Client Name')),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email')),
            TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone')),
            TextField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Country')),
            TextField(
                controller: branchController,
                decoration: InputDecoration(labelText: 'Branch')),
            TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address')),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickProfileImage,
              icon: Icon(Icons.upload),
              label: Text('Upload Profile Picture'),
            ),
            if (profileImagePath != null && profileImagePath!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Image.asset(profileImagePath!, height: 100),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onSave({
                  'name': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'country': countryController.text,
                  'branch': branchController.text,
                  'address': addressController.text,
                  'status': 'Active',
                  'profileImage': profileImagePath ?? '',
                });
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
