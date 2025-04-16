import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

// ----------------- Form Page -----------------
class QRGeneratorPage extends StatefulWidget {
  @override
  _QRGeneratorPageState createState() => _QRGeneratorPageState();
}

class _QRGeneratorPageState extends State<QRGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String domain = '';
  String role = '';
  String idNumber = '';
  String phone = '';
  String address = '';

  void _generateQR() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final qrData =
          'Name: $name\nDomain: $domain\nRole: $role\nID: $idNumber\nPhone: $phone\nAddress: $address';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRDisplayPage(data: qrData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Generator')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Name', (val) => name = val!),
              _buildTextField('Domain', (val) => domain = val!),
              _buildTextField('Role', (val) => role = val!),
              _buildTextField('ID Number', (val) => idNumber = val!),
              _buildTextField('Phone Number', (val) => phone = val!),
              _buildTextField('Address', (val) => address = val!, maxLines: 2),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateQR,
                child: Text('Generate QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        maxLines: maxLines,
        validator: (value) =>
        value == null || value.isEmpty ? 'Please enter $label' : null,
        onSaved: onSaved,
      ),
    );
  }
}

// ----------------- QR Display Page -----------------
class QRDisplayPage extends StatelessWidget {
  final String data;

  QRDisplayPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your QR Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarcodeWidget(
              barcode: Barcode.qrCode(),
              data: data,
              width: 250,
              height: 250,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Scan this QR code to view the employee details.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
