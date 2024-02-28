// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase_withdrawal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WithdrawalPhaseAdapter extends TypeAdapter<WithdrawalPhase> {
  @override
  final int typeId = 207;

  @override
  WithdrawalPhase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WithdrawalPhase(
      letter: fields[2] as String?,
    )
      ..type = fields[0] as String?
      ..name = fields[1] as String?;
  }

  @override
  void write(BinaryWriter writer, WithdrawalPhase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.letter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WithdrawalPhaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalPhase _$WithdrawalPhaseFromJson(Map<String, dynamic> json) =>
    WithdrawalPhase(
      letter: json['letter'] as String?,
    )
      ..type = json['type'] as String?
      ..name = json['name'] as String?;

Map<String, dynamic> _$WithdrawalPhaseToJson(WithdrawalPhase instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'letter': instance.letter,
    };
