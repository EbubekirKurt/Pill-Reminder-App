import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  const CustomLabel({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Text(
          label,
          style:
              TextStyle(fontSize: 15, fontWeight: FontWeight.normal, fontFamily: 'Arial',
          ),
        ));
  }
}
