import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyme/models/measure/measure.dart';

import '../widgets/action_button.dart';
import 'measure_editor_type.dart';

class MeasureEditorName extends StatefulWidget {
  final Measure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorName(
      {Key? key, required this.measure, required this.onSave, required this.save}) : super(key: key);

  @override
  MeasureEditorNameState createState() => MeasureEditorNameState();
}

class MeasureEditorNameState extends State<MeasureEditorName> {
  String? _name;

  @override
  void initState() {
    _name = widget.measure.name;
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
              Text(_name ?? ''),
              const Visibility(
                visible: true,
                child: Text(
                  'Name',
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name the data you want to collect',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: _name == null,
                initialValue: _name,
                onChanged: _changeName,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ],
          ),
        ));
  }

  _canSubmit() {
    return _name != null && _name!.isNotEmpty;
  }

  _submit() {
    widget.measure.name = _name;
    if (widget.save) {
      widget.onSave(widget.measure);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeasureEditorType(
                measure: widget.measure, onSave: widget.onSave),
          ));
    }
  }

  _changeName(text) {
    setState(() {
      _name = text;
    });
  }
}
