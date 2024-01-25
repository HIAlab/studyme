import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studyme/models/measure/list_item.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/schedule_editor.dart';

import '../widgets/action_button.dart';

class MeasureEditorList extends StatefulWidget {
  final ListMeasure measure;
  final Function(Measure measure) onSave;
  final bool save;

  const MeasureEditorList(
      {Key? key, required this.measure, required this.onSave, required this.save}) : super(key: key);

  @override
  _MeasureEditorListState createState() => _MeasureEditorListState();
}

class _MeasureEditorListState extends State<MeasureEditorList> {
  List<ListItem>? _items;
  String? _editedChoice;

  @override
  void initState() {
    _items = widget.measure.items!.toList();
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
                  'List Items',
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
              children: [
                Text('Add the items you want your list to have',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
                const SizedBox(height: 10),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items!.length,
                    itemBuilder: (content, index) {
                      ListItem choice = _items![index];

                      return Card(
                          child: ListTile(
                        title:
                            Text(choice.value!, style: const TextStyle(fontSize: 20)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeChoice(index),
                        ),
                      ));
                    }),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Add Item'),
                        onPressed: _addChoice),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addChoice() async {
    setState(() {
      _editedChoice = null;
    });
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Option"),
              content: TextFormField(
                autofocus: true,
                initialValue: null,
                onChanged: _updateEditedChoice,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      _updateEditedChoice(null);
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Confirm"))
              ],
            ));
    if (_editedChoice != null && _editedChoice!.isNotEmpty) {
      setState(() {
        _items!.add(ListItem(value: _editedChoice));
      });
    }
  }

  _updateEditedChoice(String? value) {
    setState(() {
      _editedChoice = value;
    });
  }

  _removeChoice(int index) {
    setState(() {
      _items!.removeAt(index);
    });
  }

  _canSubmit() {
    return _items!.isNotEmpty &&
        _items!.every((element) => element.value != null);
  }

  _submit() {
    widget.measure.items = _items;
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
