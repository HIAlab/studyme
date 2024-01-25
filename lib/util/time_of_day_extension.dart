import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get readable => const DefaultMaterialLocalizations()
      .formatTimeOfDay(this, alwaysUse24HourFormat: true);

  double get combined => hour + minute / 60.0;
}
