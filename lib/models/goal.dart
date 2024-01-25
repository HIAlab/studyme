import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/intervention.dart';
import 'package:uuid/uuid.dart';

part 'goal.g.dart';

@JsonSerializable()
@HiveType(typeId: 203)
class Goal {
  @HiveField(0)
  String id;

  @HiveField(1)
  String? goal;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Intervention> _suggestedInterventions;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Intervention> get suggestedInterventions => _suggestedInterventions;

  Goal({id, this.goal, suggestedInterventions})
      : id = id ?? const Uuid().v4(),
        _suggestedInterventions = suggestedInterventions ?? [];

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
