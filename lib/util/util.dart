import 'package:flutter/material.dart';

void toast(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), duration: const Duration(seconds: 10)),
  );
}

class Option {
  String? name;
  void Function()? callback;

  Option({this.name, this.callback});
}

void textToIntSetter(text, setterFunction) {
  try {
    int value = text.length > 0 ? int.parse(text) : 0;
    setterFunction(value);
  } on Exception catch (_) {
    print("Invalid number");
  }
}

void textToDoubleSetter(text, setterFunction) {
  try {
    double value = text.length > 0 ? double.parse(text) : 0;
    setterFunction(value);
  } on Exception catch (_) {
    print("Invalid number");
  }
}
