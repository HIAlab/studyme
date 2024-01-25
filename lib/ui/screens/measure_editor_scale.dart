import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/util/util.dart';

class MeasureEditorScale extends StatefulWidget {
  final ScaleMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorScale(
      {Key? key, required this.measure, required this.onSave, required this.save}) : super(key: key);

  @override
  MeasureEditorScaleState createState() => MeasureEditorScaleState();
}

class MeasureEditorScaleState extends State<MeasureEditorScale> {
  double? _min;
  String? _minLabel;
  double? _max;
  String? _maxLabel;

  @override
  void initState() {
    _min = widget.measure.min;
    _minLabel = widget.measure.minLabel;
    _max = widget.measure.max;
    _maxLabel = widget.measure.maxLabel;
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
              Text(widget.measure.name!),
              const Visibility(
                visible: true,
                child: Text(
                  'Scale',
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            ActionButton(
                icon: widget.save ? Icons.check : Icons.arrow_forward,
                canPress: _canSubmit(),
                onPressed: _submit)
          ], systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Define your scale',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 10),
                const Text('Scale ranges from',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _min!.toInt().toString(),
                  onChanged: _updateMin,
                  decoration: const InputDecoration(labelText: 'Minimum Value'),
                ),
                TextFormField(
                  initialValue: _minLabel,
                  onChanged: _updateMinLabel,
                  decoration:
                      const InputDecoration(labelText: 'Label for Minimum Value'),
                ),
                const SizedBox(height: 20),
                const Text('to',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: _max!.toInt().toString(),
                  onChanged: _updateMax,
                  decoration: const InputDecoration(labelText: 'Maximum Value'),
                ),
                TextFormField(
                  initialValue: _maxLabel,
                  onChanged: _updateMaxLabel,
                  decoration:
                      const InputDecoration(labelText: 'Label for Maximum Value'),
                ),
              ],
            ),
          ),
        ));
  }

  _updateMin(text) {
    textToDoubleSetter(text, (double number) {
      setState(() {
        _min = number;
      });
    });
  }

  _updateMinLabel(text) {
    setState(() {
      _minLabel = text;
    });
  }

  _updateMax(text) {
    textToDoubleSetter(text, (double number) {
      setState(() {
        _max = number;
      });
    });
  }

  _updateMaxLabel(text) {
    setState(() {
      _maxLabel = text;
    });
  }

  _canSubmit() {
    return _min != null &&
        _max != null &&
        _min! < _max! &&
        _minLabel != null &&
        _minLabel!.isNotEmpty &&
        _maxLabel != null &&
        _maxLabel!.isNotEmpty;
  }

  _submit() {
    widget.measure.min = _min;
    widget.measure.minLabel = _minLabel;
    widget.measure.max = _max;
    widget.measure.maxLabel = _maxLabel;
    widget.save
        ? widget.onSave(widget.measure)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: widget.measure.name,
                  objectWithSchedule: widget.measure,
                  onSave: widget.onSave),
            ));
  }
}
