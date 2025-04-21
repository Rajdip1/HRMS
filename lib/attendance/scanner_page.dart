import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:geolocator/geolocator.dart';

class ScannerPage extends StatefulWidget {
  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final MobileScannerController scannerController = MobileScannerController();
  bool isScanning = true;
  bool isProcessing = false;

  // Company location
  // final double companyLatitude = 22.540447;
  // final double companyLongitude = 72.933234;

  //Nishit's Location
  // final double companyLatitude = 22.69942099801424;
  // final double companyLongitude = 73.11914074292383;

  //My Location
  final double companyLatitude = 22.8138651;
  final double companyLongitude = 73.3436865;
  final double allowedRadiusInMeters = 100;

  @override
  void initState() {
    super.initState();
    _checkAndRequestLocationPermission();
  }

  //function for location permission of device
  Future<void> _checkAndRequestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  //function for check your location
  Future<bool> _isWithinCompanyLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        companyLatitude,
        companyLongitude,
      );
      return distanceInMeters <= allowedRadiusInMeters;
    } catch (e) {
      print("Error fetching location: $e");
      return false;
    }
  }

  //scanning function
  void _handleScan(String rawData) async {
    bool isNearCompany = await _isWithinCompanyLocation();

    if (!isNearCompany) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You are not within the company premises.")),
      );
      return;
    }

    final lines = rawData.split('\n');
    if (lines.length >= 6) {
      final position = await Geolocator.getCurrentPosition();

      final dataMap = {
        'name': lines[0].split(':').last.trim(),
        'domain': lines[1].split(':').last.trim(),
        'role': lines[2].split(':').last.trim(),
        'idNumber': lines[3].split(':').last.trim(),
        'phone': lines[4].split(':').last.trim(),
        'address': lines[5].split(':').last.trim(),
        'time': Timestamp.now(),
        'latitude': position.latitude.toString(),
        'longitude': position.longitude.toString(),
      };

      // final prefs = await SharedPreferences.getInstance();
      // final storedData = prefs.getStringList('scanned_data') ?? [];
      // storedData.add(jsonEncode(dataMap));
      // await prefs.setStringList('scanned_data', storedData);

      await FirebaseFirestore.instance.collection("attendance").add(dataMap);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) => ScannedListPage()),
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You are checked in")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid QR code format")),
      );
    }
  }

  //scan from gallery images
  Future<void> _scanFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final inputImage = InputImage.fromFilePath(picked.path);
      final barcodeScanner = BarcodeScanner();

      try {
        final barcodes = await barcodeScanner.processImage(inputImage);
        if (barcodes.isNotEmpty) {
          final code = barcodes.first.rawValue;
          if (code != null) {
            _handleScan(code);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No QR code found in the image.")),
          );
        }
      } catch (e) {
        print("Error scanning image: $e");
      } finally {
        await barcodeScanner.close();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: _scanFromGallery,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: scannerController,
            onDetect: (capture) async {
              if (!isScanning || isProcessing) return;

              final barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final code = barcodes.first.rawValue;
                if (code != null) {
                  isScanning = false;
                  isProcessing = true;
                  await scannerController.stop();
                  _handleScan(code);
                  await Future.delayed(Duration(seconds: 2));
                  isScanning = true;
                  isProcessing = false;
                  await scannerController.start();
                }
              }
            },
          ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
