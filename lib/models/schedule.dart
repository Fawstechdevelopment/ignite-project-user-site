class ClassSchedule {
  final int id;
  final String scheduledDate;
  final String timeSlot;

  ClassSchedule({required this.id, required this.scheduledDate, required this.timeSlot});
  factory ClassSchedule.fromJson(Map<String, dynamic> j) => ClassSchedule(
    id: j['id'],
    scheduledDate: j['scheduled_date'],
    timeSlot: j['time_slot'],
  );
}
