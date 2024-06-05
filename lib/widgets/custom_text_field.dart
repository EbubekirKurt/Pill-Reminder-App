

import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class TextAuth extends StatelessWidget {
  const TextAuth({
    Key? key,
     this.hintText,
    this.isSecure = false,
    this.controller,
     this.labelText,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final bool isSecure;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: grey,
        ),
      ),
      child: Center(
        child: TextField(
          style: const TextStyle(
            fontFamily: 'Arial',
          ),
          textAlign: TextAlign.left,
          cursorColor: green,
          obscureText: isSecure,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
        ),
      ),
      ),
    );
  }
}
