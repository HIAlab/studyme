import 'package:flutter/material.dart';

abstract class Task {
  String? title;
  String? body;
  TimeOfDay? time;

  String? get id => null;

  Task({this.title, this.body, this.time});

  @override
  String toString() {
    return 'Task{title: $title, body: $body, time: $time}';
  }
}
