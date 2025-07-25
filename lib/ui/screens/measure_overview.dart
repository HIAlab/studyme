import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/models/measure/scale_measure.dart';
import 'package:studyme/ui/screens/measure_editor_scale.dart';
import 'package:studyme/ui/screens/measure_editor_unit.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';
import 'package:studyme/util/string_extension.dart';

import 'measure_editor_list.dart';
import 'measure_editor_name.dart';
import 'schedule_editor.dart';

class MeasureOverview extends StatefulWidget {
  final int index;
  const MeasureOverview({super.key, required this.index});

  @override
  MeasureOverviewState createState() => MeasureOverviewState();
}

class MeasureOverviewState extends State<MeasureOverview> {
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
            Measure measure = model.trial!.measures![widget.index];
            return Scaffold(
                appBar: AppBar(
                  title: Text(measure.name!),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          EditableListTile(
                              title: const Text("Name"),
                              subtitle: Text(measure.name!,
                                  style: const TextStyle(fontSize: 16)),
                              canEdit: measure.canEdit,
                              onTap: () => _editName(measure)),
                          if (measure is KeyboardMeasure)
                            EditableListTile(
                              title: const Text("Unit"),
                              subtitle: Text(measure.unit!,
                                  style: const TextStyle(fontSize: 16)),
                              canEdit: measure.canEdit,
                              onTap: () => _editUnit(measure),
                            ),
                          ListTile(
                            title: const Text("Input Type"),
                            subtitle: Row(
                              children: [
                                Icon(measure.getIcon()),
                                const SizedBox(width: 5),
                                Text(measure.type!.capitalize(),
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          if (measure is ListMeasure)
                            EditableListTile(
                                title: const Text("List Items"),
                                subtitle: Text(measure.itemsString,
                                    style: const TextStyle(fontSize: 16)),
                                onTap: () => _editItems(measure)),
                          if (measure is ScaleMeasure)
                            EditableListTile(
                                title: const Text("Scale"),
                                subtitle: Text(measure.scaleString,
                                    style: const TextStyle(fontSize: 16)),
                                onTap: () => _editScale(measure)),
                          EditableListTile(
                              title: const Text("Schedule"),
                              subtitle: Text(measure.schedule!.readable,
                                  style: const TextStyle(fontSize: 16)),
                              onTap: () => _editSchedule(measure)),
                          OverflowBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Remove"),
                                  onPressed: _removeMeasure),
                            ],
                          ),
                        ],
                      )),
                ));
          });
  }

  void _removeMeasure() {
    setState(() {
      _isDeleting = true;
    });
    Provider.of<AppData>(context, listen: false).removeMeasure(widget.index);
    Navigator.pop(context);
  }

  void _editName(Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorName(
              measure: measure.clone(), onSave: _getSaveFunction(), save: true),
        ));
  }

  void _editUnit(Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorUnit(
              measure: measure.clone(), onSave: _getSaveFunction(), save: true),
        ));
  }

  void _editSchedule(Measure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScheduleEditor(
            title: measure.name,
            objectWithSchedule: measure,
            onSave: _getSaveFunction(),
          ),
        ));
  }

  void _editItems(ListMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorList(
              measure: measure.clone() as ListMeasure,
              onSave: _getSaveFunction(),
              save: true),
        ));
  }

  void _editScale(ScaleMeasure measure) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasureEditorScale(
              measure: measure.clone() as ScaleMeasure,
              onSave: _getSaveFunction(),
              save: true),
        ));
  }

  Null Function(Measure measure) _getSaveFunction() {
    return (Measure measure) {
      Provider.of<AppData>(context, listen: false)
          .updateMeasure(widget.index, measure);
      Navigator.pop(context);
    };
  }
}
