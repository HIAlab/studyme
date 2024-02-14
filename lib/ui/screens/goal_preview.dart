import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/goal.dart';

class GoalPreview extends StatelessWidget {
  final Goal goal;

  const GoalPreview({Key? key, required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                ListTile(
                  title: const Text("Goal"),
                  subtitle:
                      Text(goal.goal!, style: const TextStyle(fontSize: 16)),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Add to Experiment"),
                        onPressed: () => _addGoal(context)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _addGoal(BuildContext context) {
    Provider.of<AppData>(context, listen: false).setGoal(goal);
    Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
  }
}
