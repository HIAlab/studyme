import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/ui/screens/intervention_editor_instructions.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

import 'intervention_editor_name.dart';
import 'schedule_editor.dart';

class InterventionOverview extends StatefulWidget {
  final bool isA;

  const InterventionOverview({Key? key, required this.isA}) : super(key: key);

  @override
  InterventionOverviewState createState() => InterventionOverviewState();
}

class InterventionOverviewState extends State<InterventionOverview> {
  late bool _isDeleting;

  @override
  void initState() {
    _isDeleting = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isDeleting
        ? const Text('')
        : Consumer<AppData>(builder: (context, model, child) {
            Intervention intervention = widget.isA
                ? model.trial!.interventionA!
                : model.trial!.interventionB!;
            return Scaffold(
                appBar: AppBar(
                  title: Text(intervention.name!),
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        EditableListTile(
                            title: const Text("Name"),
                            subtitle: Text(intervention.name!,
                                style: const TextStyle(fontSize: 16)),
                            canEdit: true,
                            onTap: () => _editName(intervention)),
                        EditableListTile(
                            title: const Text("Instructions"),
                            subtitle: Text(intervention.instructions!,
                                style: const TextStyle(fontSize: 16)),
                            canEdit: true,
                            onTap: () => _editInstructions(intervention)),
                        if (intervention.schedule != null)
                          ListTile(
                              title: const Text("Schedule"),
                              subtitle: Text(intervention.schedule!.readable,
                                  style: const TextStyle(fontSize: 16)),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => _editSchedule(intervention)),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton.icon(
                                icon: const Icon(Icons.delete),
                                label: const Text("Remove"),
                                onPressed: _remove),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          });
  }

  _editName(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionEditorName(
              isA: widget.isA,
              intervention: intervention.clone(),
              onSave: (Intervention? intervention) {
                _getSetter()(intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editInstructions(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InterventionEditorInstructions(
              intervention: intervention.clone(),
              onSave: (Intervention? intervention) {
                _getSetter()(intervention);
                Navigator.pop(context);
              },
              save: true),
        ));
  }

  _editSchedule(intervention) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: intervention.name,
              objectWithSchedule: intervention,
              onSave: (Intervention intervention) {
                _getSetter()(intervention);
                Navigator.pop(context);
              }),
        ));
  }

  _remove() {
    setState(() {
      _isDeleting = true;
    });
    _getSetter()(null);
    Navigator.pop(context);
  }

  _getSetter() {
    return widget.isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}
