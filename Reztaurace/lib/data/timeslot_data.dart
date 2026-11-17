import '../models/timeSlot.dart';
import '../models/restaurant.dart';
import '../models/openingDay_enum.dart';


Future<List<Timeslot>> fetchTimeslots(Restaurant r) async {
  final slots = <Timeslot>[];
  final now = DateTime.now();

  String hm(DateTime d) =>
      '${d.hour}:${d.minute.toString().padLeft(2, '0')}';

  for (var i = 0; i < 7; i++) {
    final day = DateTime(now.year, now.month, now.day + i);
    final dayEnum = Day.values[day.weekday - 1];
    for (final oh in r.openingHours.where((o) => o.day == dayEnum)) {
      var t = DateTime(day.year, day.month, day.day, oh.from.hour, oh.from.minute);
      final close = DateTime(day.year, day.month, day.day, oh.to.hour, oh.to.minute);
      while (!t.add(const Duration(hours: 1)).isAfter(close)) {
        final end = t.add(const Duration(hours: 1));
        if (t.isAfter(now)) { // skip slots already in the past
          slots.add(Timeslot(
            from: t,
            title: '${hm(t)}–${hm(end)}',
          ));
        }
        t = end;
      }
    }
  }
  return slots;
}