import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/phase/phase_intervention.dart';
import 'package:studyme/models/task/intervention_task.dart';
import 'package:studyme/models/task/measure_task.dart';
import 'package:studyme/models/task/task.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/task_card.dart';

class TaskList extends StatefulWidget {
  final Trial? trial;
  final DateTime? date;

  const TaskList({Key? key, this.trial, this.date}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late bool _isLoading;

  late List<String?> _completedTaskIds;

  late List<Task> _todaysTasks;

  @override
  void initState() {
    _isLoading = true;
    _todaysTasks = widget.trial!.getTasksForDate(widget.date!);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadLogs();
  }

  loadLogs() async {
    List<String?> data =
        await Provider.of<LogData>(context).getCompletedTaskIdsFor(widget.date);
    setState(() {
      _completedTaskIds = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const CircularProgressIndicator() : _buildTaskList();
  }

  _buildTaskList() {
    Phase? currentPhase = widget.trial!.getPhaseForDate(widget.date!);
    return Column(
      children: [
        if (currentPhase is InterventionPhase) ...[
          if (!_todaysTasks.any((element) => element is InterventionTask))
            HintCard(
              titleText: 'No tasks for "${currentPhase.name}" today!',
            ),
        ],
        if (!_todaysTasks.any((element) => element is MeasureTask))
          const HintCard(
            titleText: "No data collected today!",
          ),
        if (_todaysTasks.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _todaysTasks.length,
            itemBuilder: (context, index) {
              Task task = _todaysTasks[index];
              return TaskCard(
                task: task,
                isCompleted: _completedTaskIds.contains(task.id),
              );
            },
          ),
      ],
    );
  }
}
