import 'package:flutter/material.dart';
import 'package:studyme/models/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal? goal;
  final void Function()? onTap;

  const GoalCard({super.key, this.goal, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.star, color: Colors.yellow),
        title: Text(goal!.goal!),
        trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
        onTap: onTap,
      ),
    );
  }
}
