import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/goal.dart';

class GoalPreview extends StatelessWidget {
  final Goal goal;

  const GoalPreview({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(goal.goal!),
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
