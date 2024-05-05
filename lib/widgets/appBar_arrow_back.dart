import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class AppBarArrowBack extends StatelessWidget {
  const AppBarArrowBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(7))),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
