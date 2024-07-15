import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/intervention.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';

class InterventionPreview extends StatelessWidget {
  final bool isA;
  final Intervention intervention;

  const InterventionPreview(
      {super.key, required this.intervention, required this.isA});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(intervention.name!),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text("Name"),
                  subtitle: Text(intervention.name!,
                      style: const TextStyle(fontSize: 16)),
                ),
                if (intervention.description != null)
                  ListTile(
                    title: const Text("Description"),
                    subtitle: Text(intervention.description!,
                        style: const TextStyle(fontSize: 16)),
                  ),
                if (intervention.instructions != null)
                  ListTile(
                    title: const Text("Instructions"),
                    subtitle: Text(intervention.instructions!,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Add to Experiment"),
                        onPressed: () {
                          _addIntervention(context);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addIntervention(BuildContext context) {
    saveFunction(Intervention intervention) {
      _getSetter(context)(intervention);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: intervention.name,
              objectWithSchedule: intervention,
              onSave: saveFunction),
        ));
  }

  _getSetter(BuildContext context) {
    return isA
        ? Provider.of<AppData>(context, listen: false).setInterventionA
        : Provider.of<AppData>(context, listen: false).setInterventionB;
  }
}
