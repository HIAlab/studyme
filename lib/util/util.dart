import 'package:flutter/material.dart';

toast(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), duration: Duration(seconds: 10)),
  );
}

class Option {
  String? name;
  void Function()? callback;

  Option({this.name, this.callback});
}

textToIntSetter(text, setterFunction) {
  try {
    int value = text.length > 0 ? int.parse(text) : 0;
    setterFunction(value);
  } on Exception catch (_) {
    print("Invalid number");
  }
}

textToDoubleSetter(text, setterFunction) {
  try {
    double value = text.length > 0 ? double.parse(text) : 0;
    setterFunction(value);
  } on Exception catch (_) {
    print("Invalid number");
  }
}
