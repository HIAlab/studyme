import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/task_header.dart';

import '../../models/app_state/app_data.dart';

class InterventionInteractor extends StatefulWidget {
  final InterventionTask? task;

  const InterventionInteractor(this.task, {super.key});

  @override
  InterventionInteractorState createState() => InterventionInteractorState();
}

class InterventionInteractorState extends State<InterventionInteractor> {
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task!.intervention.name!),
        actions: <Widget>[
          ActionButton(
              icon: Icons.check,
              canPress: _confirmed,
              onPressed: _markCompleted)
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              TaskHeader(task: widget.task),
              SwitchListTile(
                title: const Text("Done"),
                value: _confirmed,
                onChanged: (value) {
                  setState(() {
                    _confirmed = value;
                  });
                },
              )
            ],
          )),
    );
  }

  _markCompleted() {
    final now = Provider.of<AppData>(context, listen: false).getNow();
    Provider.of<LogData>(context, listen: false).addCompletedTaskLog(
        CompletedTaskLog(taskId: widget.task!.id, dateTime: now));
    Navigator.pop(context, true);
  }
}
