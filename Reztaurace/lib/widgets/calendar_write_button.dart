import 'package:flutter/material.dart';
import 'package:device_calendar_plus/device_calendar_plus.dart';

import 'package:reztaurace/models/restaurant.dart';
import 'package:reztaurace/models/timeSlot.dart';


class CalendarWriteButton extends StatelessWidget{
  final Restaurant restaurants;
  final Timeslot? timeslot;
  const CalendarWriteButton({super.key, required this.restaurants, this.timeslot});

  Future<void> _writeReminder(BuildContext context) async {
    final slot = timeslot;
    if (slot == null) return;

    final plugin = DeviceCalendar.instance;

    try {
      var status = await plugin.hasPermissions();
      if (status != CalendarPermissionStatus.granted) {
        status = await plugin.requestPermissions(level: CalendarAccessLevel.full);
      }
      if (status != CalendarPermissionStatus.granted) {
        await plugin.openAppSettings();
        return;
    }
    await plugin.createEvent(
      title: 'Návštěva restaurace ${restaurants.name}',
      //DateTime (Y, M,D, H,M)
      startDate: slot.from,
      endDate: slot.end,
      location: restaurants.place,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Připomínka vytvořena')),
      );
    }
  } catch (e) {
    debugPrint('createEvent failed: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nepodařilo se vytvořit připomínku')),
      );
    }
  }
 }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Icon(Icons.calendar_month_rounded),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.indigo,
            minimumSize: Size(105, 60),
            iconSize: 40,
            iconColor: Colors.blueGrey,
            textStyle: TextStyle(color: Colors.blueGrey,fontSize: 20)
        ),
        onPressed: timeslot == null ? null : () => _writeReminder(context), //restaurants[1].openingHours[2],
        label: const Text("Vytvořit připomínku")
    );
  }
}