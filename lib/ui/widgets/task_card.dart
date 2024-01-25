import 'package:flutter/material.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/ui/screens/intervention_interactor.dart';
import 'package:studyme/ui/screens/measure_interactor.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class TaskCard extends StatelessWidget {
  final Task? task;
  final bool? isCompleted;

  const TaskCard({Key? key, this.task, this.isCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Text(task!.time!.readable, style: _getTextStyle()),
      title: Text(task!.title!, style: _getTextStyle()),
      trailing: Icon(_getIcon()),
      onTap: _getOnTap(context),
    ));
  }

  IconData _getIcon() {
    return isCompleted! ? Icons.check : Icons.chevron_right;
  }

  TextStyle? _getTextStyle() {
    return isCompleted! ? const TextStyle(color: Colors.grey) : null;
  }

  Function()? _getOnTap(context) {
    return isCompleted! ? null : () => _select(context);
  }

  _select(context) {
    if (task is InterventionTask) {
      _navigateToInterventionScreen(context, task as InterventionTask?);
    } else if (task is MeasureTask) {
      _navigateToMeasureScreen(context, task as MeasureTask?);
    }
  }

  _navigateToInterventionScreen(context, InterventionTask? intervention) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InterventionInteractor(intervention)));
  }

  _navigateToMeasureScreen(context, MeasureTask? task) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MeasureInteractor(task)));
  }
}
