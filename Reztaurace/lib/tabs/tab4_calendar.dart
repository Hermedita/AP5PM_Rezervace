import 'package:flutter/material.dart';
import '../widgets/call_button.dart';
import '../widgets/calendar_write_button.dart';
import 'package:device_calendar_plus/device_calendar_plus.dart';

class Kalendar extends StatefulWidget{
  const Kalendar({super.key});

  @override
  State<Kalendar> createState() => _KalendarState();}
  class _KalendarState extends State<Kalendar> {
  var showCalendar = false;

  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  Future<void> _getPermission() async {
    final plugin = DeviceCalendar.instance;
    final status = await plugin.requestPermissions(level: CalendarAccessLevel.writeOnly);
    if (status != CalendarPermissionStatus.granted) {
      await plugin.openAppSettings();
      showCalendar = false;
    }
    else{
      showCalendar = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          //child 1 - name of the restaurant
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
                textAlign: TextAlign.center,
                "Jmeno restaurace"),
          ),
          //child 2 - calendar
          //child 3 - btns with time avaliability
          //child 4 - btn write into calendar
          CalendarWriteButton(),
          //child 5 - btn call into restaurant
          CallButton(),

        ],
    );
  }
}
//reagujici na tab2 restauraci