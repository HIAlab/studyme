import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/task/task.dart';

part 'phase_intervention.g.dart';

@JsonSerializable()
@HiveType(typeId: 206)
class InterventionPhase extends Phase {
  static const String phaseType = 'intervention';

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(3)
  Intervention intervention;

  InterventionPhase({super.letter, Intervention? intervention})
      : intervention = intervention ?? Intervention(),
        super(type: phaseType, name: intervention?.name);

  @override
  List<Task> getTasksFor(int daysSinceBeginningOfTimeRange) {
    return intervention.getTasksFor(daysSinceBeginningOfTimeRange);
  }

  factory InterventionPhase.fromJson(Map<String, dynamic> json) =>
      _$InterventionPhaseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$InterventionPhaseToJson(this);
}
