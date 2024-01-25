import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/measure_editor_unit.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

import '../widgets/action_button.dart';
import 'measure_editor_list.dart';
import 'measure_editor_scale.dart';

class MeasureEditorType extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;

  const MeasureEditorType({Key? key, required this.measure, required this.onSave}) : super(key: key);

  @override
  MeasureEditorTypeState createState() => MeasureEditorTypeState();
}

class MeasureEditorTypeState extends State<MeasureEditorType> {
  Measure? _measure;

  @override
  initState() {
    _measure = widget.measure.clone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_measure!.name!),
              const Visibility(
                visible: true,
                child: Text(
                  'Input Type',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
              icon: Icons.arrow_forward,
              canPress: _canSubmit(),
              onPressed: _submit,
            )
          ], systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'How would you like to enter the values for "${_measure!.name}"?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 10),
                ChoiceCard<String>(
                    value: KeyboardMeasure.measureType,
                    selectedValue: _measure!.type,
                    onSelect: _changeMeasureType,
                    title: const Row(
                      children: [
                        Icon(KeyboardMeasure.icon),
                        SizedBox(width: 5),
                        Text("Keyboard"),
                      ],
                    ),
                    body: const [
                      Text("Values are entered freely via the keyboard.")
                    ]),
                ChoiceCard<String>(
                    value: ListMeasure.measureType,
                    selectedValue: _measure!.type,
                    onSelect: _changeMeasureType,
                    title: const Row(
                      children: [
                        Icon(ListMeasure.icon),
                        SizedBox(width: 5),
                        Text("List"),
                      ],
                    ),
                    body: const [
                      Text(
                          "Values are selected from a list of items that you create in the next step.")
                    ]),
                ChoiceCard<String>(
                  value: ScaleMeasure.measureType,
                  selectedValue: _measure!.type,
                  onSelect: _changeMeasureType,
                  title: const Row(
                    children: [
                      Icon(ScaleMeasure.icon),
                      SizedBox(width: 5),
                      Text("Scale"),
                    ],
                  ),
                  body: const [
                    Text(
                        "Values are selected from a scale that you define in the next step.")
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _measure != null;
  }

  _submit() {
    if (_measure is ListMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorList(
                measure: _measure as ListMeasure, onSave: widget.onSave, save: false),
          ));
    } else if (_measure is ScaleMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorScale(
                measure: _measure as ScaleMeasure, onSave: widget.onSave, save: false),
          ));
    } else if (_measure is KeyboardMeasure) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorUnit(
                measure: widget.measure, onSave: widget.onSave, save: false),
          ));
    }
  }

  _changeMeasureType(String type) {
    if (type != _measure!.type) {
      Measure? newMeasure;
      if (type == KeyboardMeasure.measureType) {
        newMeasure = KeyboardMeasure();
      } else if (type == ListMeasure.measureType) {
        newMeasure = ListMeasure();
      } else if (type == ScaleMeasure.measureType) {
        newMeasure = ScaleMeasure();
      }
      newMeasure!.name = _measure!.name;
      setState(() {
        _measure = newMeasure;
      });
    }
  }
}
