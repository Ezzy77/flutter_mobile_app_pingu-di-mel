import 'package:flutter/material.dart';

class StatPage extends StatefulWidget {
  const StatPage({Key? key}) : super(key: key);

  @override
  State<StatPage> createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Stats page', style: optionStyle,),
    );
  }
}
