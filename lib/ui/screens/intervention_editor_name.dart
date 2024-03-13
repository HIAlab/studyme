import 'package:flutter/material.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/ui/screens/intervention_editor_instructions.dart';

import '../widgets/action_button.dart';

class InterventionEditorName extends StatefulWidget {
  final Intervention intervention;
  final bool isA;
  final Function(Intervention intervention) onSave;
  final bool save;

  const InterventionEditorName(
      {Key? key,
      required this.intervention,
      required this.isA,
      required this.onSave,
      required this.save})
      : super(key: key);

  @override
  InterventionEditorNameState createState() => InterventionEditorNameState();
}

class InterventionEditorNameState extends State<InterventionEditorName> {
  String? _name;

  @override
  void initState() {
    _name = widget.intervention.name;
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
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    widget.isA
                        ? 'Name the one thing you want to try out to achieve your goal'
                        : 'Name the other thing you want to try out to achieve your goal',
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
          ),
        ));
  }

  _canSubmit() {
    return _name != null && _name!.isNotEmpty;
  }

  _submit() {
    widget.intervention.name = _name;
    widget.save
        ? widget.onSave(widget.intervention)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InterventionEditorInstructions(
                  intervention: widget.intervention,
                  save: false,
                  onSave: widget.onSave),
            ));
  }

  _changeName(text) {
    setState(() {
      _name = text;
    });
  }
}
