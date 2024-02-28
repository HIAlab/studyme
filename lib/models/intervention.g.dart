// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InterventionAdapter extends TypeAdapter<Intervention> {
  @override
  final int typeId = 101;

  @override
  Intervention read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Intervention(
      id: fields[0] as dynamic,
      name: fields[1] as String?,
      description: fields[2] as String?,
      instructions: fields[3] as String?,
      schedule: fields[4] as Reminder?,
    );
  }

  @override
  void write(BinaryWriter writer, Intervention obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.instructions)
      ..writeByte(4)
      ..write(obj.schedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterventionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intervention _$InterventionFromJson(Map<String, dynamic> json) => Intervention(
      id: json['id'],
      name: json['name'] as String?,
      instructions: json['instructions'] as String?,
      schedule: json['schedule'] == null
          ? null
          : Reminder.fromJson(json['schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InterventionToJson(Intervention instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'instructions': instance.instructions,
      'schedule': instance.schedule,
    };
