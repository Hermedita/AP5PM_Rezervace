import 'package:flutter/material.dart';
import 'package:device_calendar_plus/device_calendar_plus.dart';
import 'package:reztaurace/data/restaurant_data.dart';

class CalendarWriteButton extends StatelessWidget{
  const CalendarWriteButton({super.key});

  /*
  Future<void> _getPermission() async {
    final plugin = DeviceCalendar.instance;
    final status = await plugin.requestPermissions(level: CalendarAccessLevel.writeOnly);
    if (status != CalendarPermissionStatus.granted) {
      await plugin.openAppSettings();
    }
  }
   */

  Future<void> _writeReminder() async {
    final plugin = DeviceCalendar.instance;
    final current = await plugin.hasPermissions();

    if (current == CalendarPermissionStatus.writeOnly || current == CalendarPermissionStatus.granted) {
      await plugin.createEvent(
          title: ('Návštěva restaurace ${restaurants[1].name}'),
          //DateTime (Y, M,D, H,M)
          startDate: DateTime(2024, 3, 20, 10, 0), //zalezi na timeslotu
          endDate: DateTime(2024, 3, 20, 12, 0),   //zalezi na timeslotu
          location: (restaurants[1].place)
      );
    }
    else{
      await plugin.openAppSettings();
    }
  }


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(Icons.calendar_month_rounded),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            backgroundColor: Colors.indigo,
            minimumSize: Size(105, 60),
            iconSize: 40,
            iconColor: Colors.blueGrey,
            textStyle: TextStyle(
                color: Colors.blueGrey,
                fontSize: 20
            )
        ),
        onPressed: () => {
          _writeReminder()//restaurants[1].openingHours[2]
        },
        label: const Text("Vytvořit připomínku")
    );
  }
}