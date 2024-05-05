import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class TextFieldOTP extends StatelessWidget {
  const TextFieldOTP(
      {super.key,
      required this.first,
      required this.last,
      required this.controller});

  final bool first;
  final bool last;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: green, width: 1.5),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        onChanged: (value) {
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        cursorColor: green,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 25, fontFamily: 'Arial',
        ),
        decoration: InputDecoration(
            fillColor: pureWhite,
            filled: true,
            border: InputBorder.none,
            constraints: BoxConstraints(
              maxWidth: context.getWidth() / 7.9,
              maxHeight: context.getHeight() / 8,
            )),
      ),
    );
  }
}
