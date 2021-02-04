// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScaleMeasureAdapter extends TypeAdapter<ScaleMeasure> {
  @override
  final int typeId = 2;

  @override
  ScaleMeasure read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScaleMeasure(
      id: fields[0] as dynamic,
      name: fields[2] as dynamic,
      description: fields[3] as dynamic,
      min: fields[5] as dynamic,
      max: fields[6] as dynamic,
    )
      ..initial = fields[7] as num
      ..type = fields[1] as String
      ..aggregationString = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, ScaleMeasure obj) {
    writer
      ..writeByte(8)
      ..writeByte(5)
      ..write(obj.min)
      ..writeByte(6)
      ..write(obj.max)
      ..writeByte(7)
      ..write(obj.initial)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.aggregationString);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScaleMeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
