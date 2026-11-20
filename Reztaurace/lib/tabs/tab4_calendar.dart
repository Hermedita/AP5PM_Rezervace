import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:device_calendar_plus/device_calendar_plus.dart';

import 'package:reztaurace/data/timeslot_data.dart';
//models
import 'package:reztaurace/models/restaurant.dart';
import 'package:reztaurace/models/timeSlot.dart';
//widgets
import 'package:reztaurace/widgets/call_button.dart';
import 'package:reztaurace/widgets/calendar_write_button.dart';
//states
import 'package:reztaurace/states/state_restaurant.dart';
import 'package:reztaurace/states/state_timeslot.dart';

class Kalendar extends StatefulWidget{
  const Kalendar({
  super.key,
  required this.themeMode
  });
  final ThemeMode themeMode;

  @override
  State<Kalendar> createState() => _KalendarState();}

  class _KalendarState extends State<Kalendar> {
    bool showCalendar = false;
    List<Timeslot> _slots = [];
    bool _loading_active = false;
    bool isDarkMode = false;


    static const _pageSize = 6;
      int _page = 0;
      DateTime? _day;

      bool _sameDay(DateTime a, DateTime b) =>
          a.year == b.year && a.month == b.month && a.day == b.day;

      List<DateTime> get _days {
        final days = <DateTime>[];
        for (final s in _slots) {
          if (!days.any((d) => _sameDay(d, s.from))) {
            days.add(DateTime(s.from.year, s.from.month, s.from.day));
          }
        }
        return days;
      }

      List<Timeslot> get _visibleSlots {
        final day = _day;
        if (day == null) return [];
        final forDay = _slots.where((s) => _sameDay(s.from, day)).toList();
        return forDay.skip(_page * _pageSize).take(_pageSize).toList();
      }

      int get _daySlotCount =>
          _day == null ? 0 : _slots.where((s) => _sameDay(s.from, _day!)).length;

  @override
  void initState() {
    super.initState();
    _getPermission();
    selectedRestaurant.addListener(_onRestaurantChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _onRestaurantChanged());
    //retrieveThemeMode();
  }

  @override
  void dispose() {
    selectedRestaurant.removeListener(_onRestaurantChanged);
    super.dispose();
  }

  Future<void> _onRestaurantChanged() async {
    final restaurant = selectedRestaurant.value;
    selectedTimeSlot.value = null; //reset after change
    if (restaurant == null){
      setState(() => _slots = []);
      return;
    }
    setState(() => _loading_active = true);
    final slots = await fetchTimeslots(restaurant); //db call
    if (!mounted) return;
    setState(() {
      _slots = slots;
      _loading_active = false;
      _day = slots.isEmpty ? null : _days.first;
      _page = 0;
    });
  }

  Future<void> _getPermission() async {
    if (kIsWeb) return;
    final plugin = DeviceCalendar.instance;

    var status = await plugin.hasPermissions();
      if (status != CalendarPermissionStatus.granted) {
        status = await plugin.requestPermissions(level: CalendarAccessLevel.full);
      }
      debugPrint('calendar status: $status');

      if (!mounted) return;
      setState(() => showCalendar = status == CalendarPermissionStatus.granted);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Restaurant?>(
        valueListenable: selectedRestaurant,
        builder: (context, restaurants, _){
          if (restaurants == null) {
            return const Center(
                child: Text('Vyberte restauraci v mapě'));
          }
          return ListView(
            children: [
              //child 1 - name of the restaurant
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(restaurants.name, textAlign: TextAlign.center),),
              //child 2 - calendar
              if (_loading_active) const Center(child: CircularProgressIndicator()),
              //child 3 - btns with time avaliability
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: _days.map((d) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                    selectedColor: isDarkMode ? const Color.fromARGB(255, 110, 37, 37) : const Color.fromARGB(255, 227, 144, 29),
                    backgroundColor: isDarkMode ? const Color.fromARGB(255, 186, 103, 103) : const Color.fromARGB(255, 165, 98, 0),
                      label: Text('${d.day}.${d.month}.'),
                      selected: _day != null && _sameDay(d, _day!),
                      onSelected: (_) => setState(() {
                        _day = d;
                        _page = 0;
                        selectedTimeSlot.value = null;
                      }),
                    ),
                  )).toList(),
                ),
              ),
              ValueListenableBuilder<Timeslot?>(
                valueListenable: selectedTimeSlot,
                builder: (context, selected, _) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 8,
                    children: _visibleSlots.map((slot) => ChoiceChip(
                      label: Text(slot.title),
                      selected: selected == slot,
                      onSelected: slot.isBooked ? null : (_) => selectedTimeSlot.value = slot,
                    )).toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _page > 0 ? () => setState(() => _page--) : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: (_page + 1) * _pageSize < _daySlotCount
                        ? () => setState(() => _page++)
                        : null,
                  ),
                ],
              ),
              //child 4 - btn write into calendar
              ValueListenableBuilder<Timeslot?>(
                valueListenable: selectedTimeSlot,
                builder: (context, slot, _) => CalendarWriteButton(
                  restaurants: restaurants,
                  timeslot: slot,
                ),
              ),
              //child 5 - btn call into restaurant
              CallButton(phone: restaurants.phone),
            ],
          );
        }
    );
  }
}
