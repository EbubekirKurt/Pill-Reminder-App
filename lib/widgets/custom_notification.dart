import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        width: context.getWidth(),
        height: 48,
        decoration: BoxDecoration(
          color: white,
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications_sharp,
                color: grey,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              selectedTime.format(context),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, fontFamily: 'Arial',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final TimeOfDay? picked = await showTimePicker(
      cancelText:"Çıkış",
      confirmText: "Onayla",
      initialTime: selectedTime,
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            timePickerTheme: customTimePicker(),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        GetIt.I.get<DBServices>().time=selectedTime;

      });
    }
  }
}

TimePickerThemeData customTimePicker() {
  return TimePickerThemeData(
    
    cancelButtonStyle:  const ButtonStyle( 
        backgroundColor: MaterialStatePropertyAll(
      Color(0xFF65B19F),
    )),
    confirmButtonStyle: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
      Color(0xFF65B19F),
    )),
    backgroundColor: Colors.white,
    hourMinuteShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Color(0xFF65B19F), width: 4),
    ),
    dayPeriodBorderSide: const BorderSide(color: Color(0xFF65B19F), width: 4),
    dayPeriodColor: Colors.blueGrey.shade600,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Color(0xFF65B19F), width: 4),
    ),
    dayPeriodTextColor: Colors.white,
    dayPeriodShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Color(0xFF65B19F), width: 4),
    ),
    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? const Color(0xFF65B19F)
            : const Color(0xFFF8F8F6)),
    hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? Colors.white
            : const Color(0xFF65B19F)),
    dialHandColor: Colors.blueGrey.shade700,
    dialBackgroundColor: Colors.blueGrey.shade800,
    hourMinuteTextStyle:
        const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    dayPeriodTextStyle:
        const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    helpTextStyle: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(

      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.selected)
            ? const Color(0xFF65B19F)
            : Colors.white),
    entryModeIconColor: const Color(0xFF65B19F),
  );
}
