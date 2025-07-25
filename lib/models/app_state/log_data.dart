import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/log/trial_log.dart';
import 'package:studyme/models/measure/measure.dart';

class LogData extends ChangeNotifier {
  static const completedTaskIdsKey = 'completedTasks';

  void addCompletedTaskLog(CompletedTaskLog log) async {
    Box box = await Hive.openBox(completedTaskIdsKey);
    box.add(log);
    notifyListeners();
  }

  Future<List<String?>> getCompletedTaskIdsFor(DateTime date) async {
    Box box = await Hive.openBox(completedTaskIdsKey);
    List<CompletedTaskLog> logs = box.values.toList().cast<CompletedTaskLog>();
    // remove entries that are not from today
    logs.removeWhere((log) {
      return log.dateTime.year != date.year ||
          log.dateTime.month != date.month ||
          log.dateTime.day != date.day;
    });
    return logs.map((log) => log.taskId).toList();
  }

  Future<List<TrialLog>> getMeasureLogs(Measure measure) async {
    Box box = await Hive.openBox(measure.id!);
    return box.values.toList().cast<TrialLog>();
  }

  void checkForDuplicatesAndAdd(List<TrialLog> newLogs, Measure measure) async {
    List<TrialLog> existingLogs = await getMeasureLogs(measure);
    List<String> existingLogIds = existingLogs.map((log) => log.id).toList();
    List<TrialLog> uniqueNewLogs = [];
    for (var log in newLogs) {
      if (!existingLogIds.contains(log.id)) {
        uniqueNewLogs.add(log);
      }
    }
    addMeasureLogs(uniqueNewLogs, measure);
  }

  void addMeasureLogs(List<TrialLog> logs, Measure measure) async {
    await _addLogsFor(measure.id!, logs);
    notifyListeners();
  }

  Future<void> _addLogsFor(String boxname, List<TrialLog> logs) async {
    Box box = await Hive.openBox(boxname);
    for (var log in logs) {
      box.add(log);
    }
  }
}
