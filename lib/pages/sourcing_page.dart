import 'package:flutter/material.dart';

class SourcingPage extends StatelessWidget {
  final String title;
  SourcingPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(title, style: TextStyle(fontSize: 12.0))]);
  }
}
