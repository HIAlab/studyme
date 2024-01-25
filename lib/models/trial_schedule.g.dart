// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trial_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrialScheduleAdapter extends TypeAdapter<TrialSchedule> {
  @override
  final int typeId = 201;

  @override
  TrialSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrialSchedule()
      ..phaseOrder = fields[0] as PhaseOrder?
      ..phaseDuration = fields[1] as int?
      ..phaseSequence = (fields[2] as List?)?.cast<String>()
      ..numberOfPhasePairs = fields[3] as int?;
  }

  @override
  void write(BinaryWriter writer, TrialSchedule obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.phaseOrder)
      ..writeByte(1)
      ..write(obj.phaseDuration)
      ..writeByte(2)
      ..write(obj.phaseSequence)
      ..writeByte(3)
      ..write(obj.numberOfPhasePairs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrialScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrialSchedule _$TrialScheduleFromJson(Map<String, dynamic> json) =>
    TrialSchedule()
      ..phaseOrder =
          $enumDecodeNullable(_$PhaseOrderEnumMap, json['phaseOrder'])
      ..phaseDuration = json['phaseDuration'] as int?
      ..phaseSequence = (json['phaseSequence'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..numberOfPhasePairs = json['numberOfPhasePairs'] as int?;

Map<String, dynamic> _$TrialScheduleToJson(TrialSchedule instance) =>
    <String, dynamic>{
      'phaseOrder': _$PhaseOrderEnumMap[instance.phaseOrder],
      'phaseDuration': instance.phaseDuration,
      'phaseSequence': instance.phaseSequence,
      'numberOfPhasePairs': instance.numberOfPhasePairs,
    };

const _$PhaseOrderEnumMap = {
  PhaseOrder.alternating: 'alternating',
  PhaseOrder.counterbalanced: 'counterbalanced',
};
