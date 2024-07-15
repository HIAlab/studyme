import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';
import 'package:studyme/util/string_extension.dart';

class MeasurePreview extends StatelessWidget {
  final Measure measure;

  const MeasurePreview({super.key, required this.measure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(measure.name!),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: const Text("Name"),
                    subtitle: Text(measure.name!,
                        style: const TextStyle(fontSize: 16)),
                  ),
                  if (measure is KeyboardMeasure)
                    ListTile(
                      title: const Text("Unit"),
                      subtitle: Text(measure.unit!,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ListTile(
                    title: const Text("Input Type"),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(measure.getIcon()),
                            const SizedBox(width: 5),
                            Text(measure.type!.capitalize(),
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (measure is ListMeasure)
                    ListTile(
                      title: const Text("List Items"),
                      subtitle: Text((measure as ListMeasure).itemsString,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  if (measure is ScaleMeasure)
                    ListTile(
                      title: const Text("Scale"),
                      subtitle: Text((measure as ScaleMeasure).scaleString,
                          style: const TextStyle(fontSize: 16)),
                    ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text("Add to Experiment"),
                          onPressed: () => _addMeasure(context)),
                    ],
                  ),
                ],
              )),
        ));
  }

  _addMeasure(BuildContext context) {
    saveFunction(Measure measure) {
      Provider.of<AppData>(context, listen: false).addMeasure(measure);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    }

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
              title: measure.name,
              objectWithSchedule: measure,
              onSave: saveFunction),
        ));
  }
}
