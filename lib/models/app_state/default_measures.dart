import 'package:health/health.dart';
import 'package:studyme/models/measure/choice.dart';
import 'package:studyme/models/measure/choice_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/synced_measure.dart';

List<Measure> get defaultMeasures {
  int id = 0;
  return [
    ChoiceMeasure(id: (id++).toString(), name: 'Rate your pain', choices: [
      Choice(value: 'Low'),
      Choice(value: 'Medium'),
      Choice(value: 'High')
    ]),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Weight',
        healthDataType: HealthDataType.WEIGHT),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Heart Rate',
        healthDataType: HealthDataType.HEART_RATE),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Glucose',
        healthDataType: HealthDataType.BLOOD_GLUCOSE),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Oxygen',
        healthDataType: HealthDataType.BLOOD_OXYGEN),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Pressure Diastolic',
        healthDataType: HealthDataType.BLOOD_PRESSURE_DIASTOLIC),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Blood Pressure Systolic',
        healthDataType: HealthDataType.BLOOD_PRESSURE_SYSTOLIC),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Body Temperature',
        healthDataType: HealthDataType.BODY_TEMPERATURE),
    SyncedMeasure(
        id: (id++).toString(),
        name: 'Body Fat Percentage',
        healthDataType: HealthDataType.BODY_FAT_PERCENTAGE),
  ];
}
