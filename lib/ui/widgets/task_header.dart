import 'package:flutter/material.dart';
import 'package:studyme/models/task/task.dart';

import 'package:studyme/util/time_of_day_extension.dart';

class TaskHeader extends StatelessWidget {
  final Task? task;

  const TaskHeader({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.alarm),
              const SizedBox(width: 10),
              Text(task!.time!.readable,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 5),
          Text(task!.title!, style: const TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
