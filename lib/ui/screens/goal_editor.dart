import 'package:flutter/material.dart';
import 'package:studyme/models/goal.dart';
import 'package:studyme/ui/widgets/action_button.dart';

class GoalEditor extends StatefulWidget {
  final Goal goal;
  final Function(Goal goal) onSave;

  const GoalEditor({super.key, required this.goal, required this.onSave});

  @override
  GoalEditorState createState() => GoalEditorState();
}

class GoalEditorState extends State<GoalEditor> {
  String? _goal;

  @override
  void initState() {
    _goal = widget.goal.goal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            ActionButton(
                icon: Icons.check, canPress: _canSubmit(), onPressed: _onSubmit)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                      "What do you want to improve about your health or well-being?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor)),
                ),
                const SizedBox(height: 10),
                Text("I want to...",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor)),
                TextFormField(
                  autofocus: _goal == null,
                  initialValue: _goal,
                  onChanged: _changeGoal,
                ),
              ],
            ),
          ),
        ));
  }

  _canSubmit() {
    return _goal != null && _goal!.isNotEmpty;
  }

  _onSubmit() {
    widget.onSave(Goal(goal: _goal));
  }

  _changeGoal(String value) {
    setState(() {
      _goal = value;
    });
  }
}
