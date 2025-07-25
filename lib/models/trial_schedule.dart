import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/phase_order.dart';

part 'trial_schedule.g.dart';

@JsonSerializable()
@HiveType(typeId: 201)
class TrialSchedule extends HiveObject {
  @HiveField(0)
  PhaseOrder? phaseOrder;

  @HiveField(1)
  int? phaseDuration;

  @HiveField(2)
  List<String>? phaseSequence;

  @HiveField(3)
  int? numberOfPhasePairs;

  int get numberOfPhases => phaseSequence!.length;

  TrialSchedule();

  TrialSchedule.createDefault() {
    phaseOrder = PhaseOrder.alternating;
    phaseDuration = 7;
    numberOfPhasePairs = 2;
    _updatePhaseSequence();
  }

  TrialSchedule.clone(TrialSchedule schedule)
      : phaseOrder = schedule.phaseOrder,
        phaseDuration = schedule.phaseDuration,
        phaseSequence = schedule.phaseSequence,
        numberOfPhasePairs = schedule.numberOfPhasePairs;

  TrialSchedule clone() {
    return TrialSchedule.clone(this);
  }

  int get totalDuration => phaseDuration! * numberOfPhases;

  void updatePhaseOrder(PhaseOrder? newPhaseOrder) {
    phaseOrder = newPhaseOrder;
    _updatePhaseSequence();
  }

  void updateNumberOfCycles(int newNumberOfCycles) {
    numberOfPhasePairs = newNumberOfCycles;
    _updatePhaseSequence();
  }

  void _updatePhaseSequence() {
    List<String> pair = ['a', 'b'];
    List<String> newPhaseSequence = [];

    for (int i = 0; i < numberOfPhasePairs!; i++) {
      newPhaseSequence.addAll(pair);
      if (phaseOrder == PhaseOrder.counterbalanced) {
        pair = pair.reversed.toList();
      }
    }
    phaseSequence = newPhaseSequence;
  }

  factory TrialSchedule.fromJson(Map<String, dynamic> json) =>
      _$TrialScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$TrialScheduleToJson(this);
}
