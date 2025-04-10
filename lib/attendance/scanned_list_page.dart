import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detail_page.dart';

class ScannedListPage extends StatefulWidget {
  @override
  _ScannedListPageState createState() => _ScannedListPageState();
}

class _ScannedListPageState extends State<ScannedListPage> {
  List<Map<String, dynamic>> scannedDataList = [];

  @override
  void initState() {
    super.initState();
    _loadScannedData();
  }

  //function to load scanned data
  void _loadScannedData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getStringList('scanned_data') ?? [];
    setState(() {
      scannedDataList = storedData
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList()
          .reversed
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Check-ins")),
      body: scannedDataList.isEmpty
          ? Center(child: Text("No scans yet."))
          : ListView.builder(
        itemCount: scannedDataList.length,
        itemBuilder: (context, index) {
          final data = scannedDataList[index];
          final checkInTime = TimeOfDay.fromDateTime(
              DateTime.parse(data['time']))
              .format(context);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(data: data),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data['name'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(checkInTime,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
