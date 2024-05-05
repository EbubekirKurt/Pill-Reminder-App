import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';

class DropMenu extends StatefulWidget {
  const DropMenu({
    Key? key,
  }) : super(key: key);
  @override
  _DropMenuState createState() => _DropMenuState();
}

class _DropMenuState extends State<DropMenu> {
  int _selectedNumberPill = 1;
  int _selectedNumberDay = 1;
  int CountPill = 15;
  int CountDay = 30;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 151,
          height: 48,
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset("assets/icons/pells.svg"),
                Text("$_selectedNumberPill", style: const TextStyle(
                  fontFamily: 'Arial',
                ),),
                DropdownButton<int>(
                  
                  menuMaxHeight: 100,
                  dropdownColor: pureWhite,
                  borderRadius: BorderRadius.circular(20),
                  icon: const Icon(Icons.arrow_drop_down),
                 hint: const Text("Hap", style: TextStyle(
                    fontFamily: 'Arial',
                  ),),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedNumberPill = newValue;
                        GetIt.I.get<DBServices>().pellCount=newValue;
                      });
                    }
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    CountPill,
                    (int index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color:greenLight),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${index+1}', textAlign: TextAlign.center, style: const TextStyle(
                                fontFamily: 'Arial',
                              ),),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          width: 151,
          height: 48,
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.date_range_rounded, color: grey),
                Text("$_selectedNumberDay"),
                DropdownButton<int>(
                  menuMaxHeight: 100,
                  dropdownColor: pureWhite,
                  borderRadius: BorderRadius.circular(20),

                  icon: const Icon(Icons.arrow_drop_down),
                  hint: const Text("Gün"),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedNumberDay = newValue;
                      GetIt.I.get<DBServices>().pellPireod=newValue;

                      });
                    }
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    CountDay,
                    (int index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color:greenLight),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('${index + 1}', textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
