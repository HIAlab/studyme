import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/reminder.dart';

part 'keyboard_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class KeyboardMeasure extends Measure {
  static const String measureType = 'keyboard';

  static const IconData icon = Icons.dialpad;

  KeyboardMeasure(
      {super.id, super.name, String? description, super.unit, super.schedule})
      : super(type: measureType);

  KeyboardMeasure.clone(KeyboardMeasure super.measure) : super.clone();

  factory KeyboardMeasure.fromJson(Map<String, dynamic> json) =>
      _$KeyboardMeasureFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$KeyboardMeasureToJson(this);
}
