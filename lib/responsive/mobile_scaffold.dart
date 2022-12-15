import 'package:flutter/material.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({Key? key}) : super(key: key);

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pingu Di Mel'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[300],

    );
  }
}
