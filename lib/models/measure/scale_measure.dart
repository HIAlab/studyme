import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/measure.dart';

import '../reminder.dart';

part 'scale_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class ScaleMeasure extends Measure {
  static const String measureType = 'scale';

  static const IconData icon = Icons.linear_scale;

  @HiveField(5)
  double? min;

  @HiveField(6)
  String? minLabel;

  @HiveField(7)
  double? max;

  @HiveField(8)
  String? maxLabel;

  @HiveField(9)
  double? initial;

  String get scaleString =>
      "From:\t${min!.toInt().toString()} ($minLabel), To: ${max!.toInt().toString()} ($maxLabel) ";

  ScaleMeasure(
      {super.id,
      super.name,
      String? description,
      double? min,
      this.minLabel,
      double? max,
      this.maxLabel,
      super.schedule})
      : min = min ?? 0.0,
        max = max ?? 10.0,
        super(type: measureType);

  ScaleMeasure.clone(ScaleMeasure super.measure)
      : min = measure.min,
        max = measure.max,
        initial = measure.initial,
        super.clone();

  factory ScaleMeasure.fromJson(Map<String, dynamic> json) =>
      _$ScaleMeasureFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ScaleMeasureToJson(this);
}
