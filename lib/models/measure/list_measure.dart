import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/measure.dart';

import '../reminder.dart';

part 'list_measure.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class ListMeasure extends Measure {
  static const String measureType = 'list';

  static const IconData icon = Icons.list;

  @HiveField(5)
  List<ListItem>? items;

  String get itemsString => items!.fold(
      '',
      (previousValue, element) =>
          previousValue +
          (previousValue.isNotEmpty ? ', ' : '') +
          element.value!);

  ListMeasure(
      {String? id,
      String? name,
      String? description,
      List<ListItem>? items,
      Reminder? schedule})
      : items = items ?? [],
        super(id: id, type: measureType, name: name, schedule: schedule);

  ListMeasure.clone(ListMeasure measure)
      : items = List.of(measure.items!),
        super.clone(measure);

  @override
  dynamic get tickProvider => charts.NumericAxisSpec(
        tickProviderSpec: charts.StaticNumericTickProviderSpec(
          <charts.TickSpec<num>>[
            ...items!
                .asMap()
                .entries
                .map((e) => TickSpec<num>(e.key, label: e.value.value))
                
          ],
        ),
      );

  factory ListMeasure.fromJson(Map<String, dynamic> json) =>
      _$ListMeasureFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ListMeasureToJson(this);
}
