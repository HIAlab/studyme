import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/ui/screens/goal_library.dart';
import 'package:studyme/ui/widgets/goal_card.dart';

import 'goal_overview.dart';

class CreatorGoalSection extends StatelessWidget {
  final AppData model;

  const CreatorGoalSection(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your goal',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColor)),
        if (!_goalIsSet())
          OverflowBar(
            alignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Select'),
                  onPressed: () => _addGoal(context)),
            ],
          ),
        if (_goalIsSet())
          GoalCard(goal: model.trial!.goal, onTap: () => _viewGoal(context))
      ],
    );
  }

  bool _goalIsSet() {
    return model.trial!.goal != null;
  }

  void _addGoal(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GoalLibrary(),
      ),
    );
  }

  void _viewGoal(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GoalOverview(),
      ),
    );
  }
}
