import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/phase/phase_intervention.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/phase/phase_withdrawal.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/util/time_of_day_extension.dart';

import './measure/measure.dart';
import 'intervention.dart';
import 'goal.dart';

part 'trial.g.dart';

@JsonSerializable()
@HiveType(typeId: 200)
class Trial extends HiveObject {
  @HiveField(0)
  Goal? goal;

  @HiveField(1)
  TrialType? type;

  @HiveField(2)
  Intervention? interventionA;

  @HiveField(3)
  Intervention? interventionB;

  @HiveField(4)
  Phase? a;

  @HiveField(5)
  Phase? b;

  @HiveField(6)
  List<Measure>? measures;

  @HiveField(7)
  TrialSchedule? schedule;

  @HiveField(8)
  DateTime? startDate;

  @HiveField(9)
  Map<DateTime, String>? stepsLogForSurvey;

  List<Task> getTasksForDate(DateTime date) {
    DateTime cleanDate = DateTime(date.year, date.month, date.day);
    List<Task> tasks = [];

    if (date.isAfter(startDate!) && date.isBefore(endDate)) {
      int daysSinceBeginningOfTrial = cleanDate.difference(startDate!).inDays;
      int daysSinceBeginningOfPhase =
          daysSinceBeginningOfTrial % schedule!.phaseDuration!;

      Phase phase = getPhaseForDate(cleanDate)!;

      tasks.addAll(phase.getTasksFor(daysSinceBeginningOfPhase));
      for (var measure in measures!) {
        tasks.addAll(measure.getTasksFor(daysSinceBeginningOfTrial));
      }

      tasks.sort((a, b) {
        if (a.time!.combined < b.time!.combined) {
          return -1;
        } else if (a.time!.combined > b.time!.combined) {
          return 1;
        } else {
          return 0;
        }
      });
    } else {
      print("experiment has ended");
    }

    return tasks;
  }

  Trial()
      : measures = [],
        stepsLogForSurvey = {};

  DateTime get endDate {
    return startDate!
        .add(Duration(days: schedule!.totalDuration))
        .subtract(const Duration(seconds: 1));
  }

  int getDayOfStudyFor(DateTime date) {
    return date.differenceInDays(startDate!).inDays;
  }

  bool isInStudyTimeframe(DateTime date) {
    return date.isAfter(startDate!) && date.isBefore(endDate);
  }

  Phase? getPhaseForDate(DateTime date) {
    final index = getPhaseIndexForDate(date);

    return getPhaseForPhaseIndex(index);
  }

  Phase? getPhaseForPhaseIndex(int index) {
    if (index < 0 || index >= schedule!.numberOfPhases) {
      print('trial is over or has not begun.');
      return null;
    }
    final letter = schedule!.phaseSequence![index];

    if (letter == 'a') {
      return a;
    } else if (letter == 'b') {
      return b;
    } else {
      return null;
    }
  }

  int getPhaseIndexForDate(DateTime date) {
    final test = date.differenceInDays(startDate!).inDays;
    return test ~/ schedule!.phaseDuration!;
  }

  void generateWithSetInfos() {
    schedule = TrialSchedule.createDefault();
    if (type == TrialType.reversal) {
      a = WithdrawalPhase.fromIntervention(
          letter: 'a', withdrawnIntervention: interventionA!);
      b = InterventionPhase(letter: 'b', intervention: interventionA!);
    } else {
      a = InterventionPhase(letter: 'a', intervention: interventionA!);
      b = InterventionPhase(letter: 'b', intervention: interventionB!);
    }
  }

  factory Trial.fromJson(Map<String, dynamic> json) => _$TrialFromJson(json);
  Map<String, dynamic> toJson() => _$TrialToJson(this);
}

extension DateOnlyCompare on DateTime {
  // needed for models
  Duration differenceInDays(DateTime other) {
    final currentZero = DateTime(year, month, day);
    final otherZero = DateTime(other.year, other.month, other.day);
    return currentZero.difference(otherZero);
  }
}
