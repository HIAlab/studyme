import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/models/mixins/has_schedule.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:uuid/uuid.dart';

import '../reminder.dart';
import '../task/task.dart';
import 'keyboard_measure.dart';
import 'list_measure.dart';

typedef MeasureTaskParser = Measure Function(Map<String, dynamic> data);

abstract class Measure with HasSchedule {
  static Map<String, MeasureTaskParser> measureTypes = {
    ListMeasure.measureType: (json) => ListMeasure.fromJson(json),
    KeyboardMeasure.measureType: (json) => KeyboardMeasure.fromJson(json),
    ScaleMeasure.measureType: (json) => ScaleMeasure.fromJson(json),
  };

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? type;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? unit;

  @override
  @HiveField(4)
  Reminder? schedule;

  static IconData? icon;

  Measure({this.id, this.type, this.name, this.unit, Reminder? schedule}) {
    id = id ?? const Uuid().v4();
    this.schedule = schedule ?? Reminder();
  }

  Measure.clone(Measure measure) {
    id = const Uuid().v4();
    type = measure.type;
    name = measure.name;
    unit = measure.unit;
    schedule = measure.schedule;
  }

  IconData? getIcon() {
    switch (runtimeType) {
      case const (KeyboardMeasure):
        return KeyboardMeasure.icon;
      case const (ListMeasure):
        return ListMeasure.icon;
      case const (ScaleMeasure):
        return ScaleMeasure.icon;
      default:
        return null;
    }
  }

  Measure clone() {
    switch (runtimeType) {
      case const (KeyboardMeasure):
        return KeyboardMeasure.clone(this as KeyboardMeasure);
      case const (ListMeasure):
        return ListMeasure.clone(this as ListMeasure);
      case const (ScaleMeasure):
        return ScaleMeasure.clone(this as ScaleMeasure);
    }
  }

  Future<bool> get canAdd => Future.value(true);

  bool get canEdit => true;

  dynamic get tickProvider => null;

  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    List<TimeOfDay> times =
        schedule!.getTaskTimesFor(daysSinceBeginningOfTimeRange);
    return times.map((time) => MeasureTask(this, time)).toList();
  }

  Map<String, dynamic> toJson();

  factory Measure.fromJson(Map<String, dynamic> data) =>
      measureTypes[data["measureType"]]!(data);
}
