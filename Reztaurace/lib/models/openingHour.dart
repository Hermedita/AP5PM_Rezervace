import 'package:flutter/material.dart';
import '../models/openingDay_enum.dart';

class OpeningHour {
  final Day day;        //enum
  final TimeOfDay from; //hours and minutes
  final TimeOfDay to;   //hours and minutes

  const OpeningHour({
    required this.day,
    required this.from,
    required this.to
});
}