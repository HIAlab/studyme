import 'package:flutter/material.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';

class KeyboardMeasureWidget extends StatelessWidget {
  final KeyboardMeasure? measure;

  final void Function(num value)? updateValue;

  const KeyboardMeasureWidget(this.measure, this.updateValue, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: updateValue != null ? true : false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: measure!.unit),
        onChanged: (text) {
          num? value;
          if (updateValue != null) {
            try {
              value = text.isNotEmpty ? num.parse(text) : null;
            } on Exception catch (_) {
              value = null;
            }

            updateValue!(value!);
          }
        });
  }
}
