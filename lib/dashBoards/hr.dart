import 'package:flutter/material.dart';

class Hr extends StatefulWidget {
  const Hr({super.key});

  @override
  State<Hr> createState() => _HrState();
}

class _HrState extends State<Hr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('HR profile'),
    );
  }
}
