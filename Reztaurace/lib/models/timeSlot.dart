class Timeslot {
  final DateTime from;
  final Duration duration;
  final bool isBooked;
  final String title;

  const Timeslot ({
    required this.from,
    this.duration = const Duration(hours: 1),
    this.isBooked = false,
    required this.title,
});

  DateTime get end => from.add(duration);

  @override
  bool operator ==(Object other) =>
      other is Timeslot && other.from == from && other.duration == duration;

  @override
  int get hashCode => Object.hash(from, duration);
}

