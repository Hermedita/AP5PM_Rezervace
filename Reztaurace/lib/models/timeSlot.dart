class Timeslot {
  final DateTime from;
  final Duration duration;
  final bool isBooked;

  const Timeslot ({
    required this.from,
    this.duration = const Duration(hours: 1),
    this.isBooked = false
});

  DateTime get end => from.add(duration);
}

