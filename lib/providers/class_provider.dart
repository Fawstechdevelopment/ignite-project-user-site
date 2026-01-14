import 'package:flutter/material.dart';
import 'package:ignite_project_user_site/models/schedule.dart';
import '../services/api_service.dart';
import '../services/endpoints.dart';

class ClassProvider extends ChangeNotifier {
  List<ClassSchedule> classes = [];
  bool loading = false;

  Future<bool> scheduleClass({
    int? activeProjectId,
    int? requestId,
    required String scheduledDate,
    required String timeSlot,
    int? classNumber,
  }) async {
    loading = true; notifyListeners();
    try {
      final body = <String, dynamic>{
        "scheduled_date": scheduledDate,
        "time_slot": timeSlot,
      };
      if (activeProjectId != null) {
        body["active_project_id"] = activeProjectId;
        body["class_number"] = classNumber ?? 1;
      } else if (requestId != null) {
        body["request_id"] = requestId;
      }
      final res = await ApiService.dio.post(Endpoints.classesSchedule, data: body);
      loading = false; notifyListeners();
      return res.statusCode == 200 || res.statusCode == 201;
    } catch (e) {
      loading = false; notifyListeners();
      return false;
    }
  }

  Future<void> fetchSchedules() async {
    loading = true; notifyListeners();
    try {
      final res = await ApiService.dio.get(Endpoints.classesSchedule);
      if (res.statusCode == 200) {
        classes = (res.data as List).map((j) => ClassSchedule.fromJson(j)).toList();
      }
    } catch (e) {}
    loading = false; notifyListeners();
  }

  Future<bool> reschedule(int id, String date, String time) async {
    final res = await ApiService.dio.patch(Endpoints.classReschedule(id), data: {"scheduled_date": date, "time_slot": time});
    return res.statusCode == 200;
  }
}
