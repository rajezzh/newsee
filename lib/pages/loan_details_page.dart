import 'package:flutter/material.dart';

class LoanDetailsPage extends StatelessWidget {
  final String title;
  LoanDetailsPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(title, style: TextStyle(fontSize: 12.0))]);
  }
}
