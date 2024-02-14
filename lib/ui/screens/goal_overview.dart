import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/goal.dart';
import 'package:studyme/ui/screens/goal_editor.dart';
import 'package:studyme/ui/widgets/editable_list_tile.dart';

class GoalOverview extends StatefulWidget {
  const GoalOverview({Key? key}) : super(key: key);

  @override
  GoalOverviewState createState() => GoalOverviewState();
}

class GoalOverviewState extends State<GoalOverview> {
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
            Goal goal = model.trial!.goal!;
            return Scaffold(
                appBar: AppBar(
                  title: Text(goal.goal!),
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        EditableListTile(
                            title: const Text("Goal"),
                            subtitle: Text(goal.goal!,
                                style: const TextStyle(fontSize: 16)),
                            onTap: () => _editGoal(goal)),
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

  _editGoal(Goal goal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalEditor(
            goal: goal,
            onSave: (Goal goal) {
              _getSetter()(goal);
              Navigator.pop(context);
            }),
      ),
    );
  }

  _remove() {
    setState(() {
      _isDeleting = true;
    });
    _getSetter()();
    Navigator.pop(context);
  }

  _getSetter() {
    return Provider.of<AppData>(context, listen: false).setGoal;
  }
}
