import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/task_header.dart';

class InterventionInteractor extends StatefulWidget {
  final InterventionTask? task;

  const InterventionInteractor(this.task, {Key? key}) : super(key: key);

  @override
  _InterventionInteractorState createState() => _InterventionInteractorState();
}

class _InterventionInteractorState extends State<InterventionInteractor> {
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
        ], systemOverlayStyle: SystemUiOverlayStyle.light,
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
    var now = DateTime.now();
    Provider.of<LogData>(context, listen: false).addCompletedTaskLog(
        CompletedTaskLog(taskId: widget.task!.id, dateTime: now));
    Navigator.pop(context, true);
  }
}
