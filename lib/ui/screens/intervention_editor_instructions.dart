import 'package:flutter/material.dart';
import 'package:studyme/models/intervention.dart';

import '../widgets/action_button.dart';
import 'schedule_editor.dart';

class InterventionEditorInstructions extends StatefulWidget {
  final Intervention? intervention;

  final Function(Intervention? intervention) onSave;
  final bool save;

  const InterventionEditorInstructions(
      {Key? key,
      required this.intervention,
      required this.onSave,
      required this.save})
      : super(key: key);

  @override
  InterventionEditorInstructionsState createState() =>
      InterventionEditorInstructionsState();
}

class InterventionEditorInstructionsState
    extends State<InterventionEditorInstructions> {
  String? _instructions;

  @override
  void initState() {
    _instructions = widget.intervention!.instructions;
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
              Text(widget.intervention!.name!),
              const Visibility(
                visible: true,
                child: Text(
                  'Instructions',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Enter instructions* for yourself',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  autofocus: _instructions == null,
                  initialValue: _instructions,
                  onChanged: _changeInstructions,
                  decoration: const InputDecoration(
                    labelText: 'Instructions',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    '* The instructions will be shown to you when it is time for "${widget.intervention!.name}".\nAim to be specific enough so you will know what to do.',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _instructions != null && _instructions!.isNotEmpty;
  }

  _submit() {
    widget.intervention!.instructions = _instructions;
    widget.save
        ? widget.onSave(widget.intervention)
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleEditor(
                  title: widget.intervention!.name,
                  objectWithSchedule: widget.intervention,
                  onSave: widget.onSave),
            ));
  }

  _changeInstructions(text) {
    setState(() {
      _instructions = text;
    });
  }
}
