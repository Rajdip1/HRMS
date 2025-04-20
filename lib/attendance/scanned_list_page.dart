import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'detail_page.dart';

class ScannedListPage extends StatefulWidget {
  @override
  _ScannedListPageState createState() => _ScannedListPageState();
}

class _ScannedListPageState extends State<ScannedListPage> {
  List<Map<String, dynamic>> scannedDataList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _loadScannedData();
  // }

  // //function to load scanned data
  // void _loadScannedData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final storedData = prefs.getStringList('scanned_data') ?? [];
  //   setState(() {
  //     scannedDataList = storedData
  //         .map((e) => jsonDecode(e) as Map<String, dynamic>)
  //         .toList()
  //         .reversed
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Check-ins")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("attendance").orderBy('time', descending: true).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No Scanned Yet'),);
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
                itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                DateTime dateTime;
                final timeField = data['time'];

                // Check if it's a Timestamp or String
                if (timeField is Timestamp) {
                  dateTime = timeField.toDate();
                } else if (timeField is String) {
                  dateTime = DateTime.tryParse(timeField) ?? DateTime.now(); // Fallback in case of bad string
                } else {
                  dateTime = DateTime.now(); // Fallback default
                }

                final checkInTime = TimeOfDay.fromDateTime(dateTime).format(context);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(data: data)));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 6)]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data['name'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          Text(checkInTime,style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                        ]
                      ),
                    ),
                  ),
                );
              }
            );
          }
      )
    );
  }
}
