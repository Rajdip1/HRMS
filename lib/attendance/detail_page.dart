import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPage({required this.data});

  String _formatTimestamp(dynamic timeField) {
    if (timeField is Timestamp) {
      return DateFormat('dd MMM yyyy, hh:mm a').format(timeField.toDate());
    } else if (timeField is String) {
      return timeField;
    } else {
      return 'Unknown';
    }
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: Text('Scanned Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 8)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDetailRow('Name', data['name']),
                _buildDetailRow('Domain', data['domain']),
                _buildDetailRow('Role', data['role']),
                _buildDetailRow('ID Number', data['idNumber']),
                _buildDetailRow('Phone', data['phone']),
                _buildDetailRow('Address', data['address']),
                _buildDetailRow('Scanned At', _formatTimestamp(data['time'])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
