import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/ui/screens/creator_3_schedule.dart';
import 'package:studyme/ui/widgets/hightlighted_action_button.dart';
import 'package:studyme/ui/widgets/phase_card.dart';
import 'package:studyme/ui/widgets/measure_card.dart';
import 'package:studyme/ui/widgets/goal_card.dart';

class CreatorSetup extends StatelessWidget {
  const CreatorSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Your Experiment'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('You will compare data on',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              ...model.trial!.measures!
                  .map((measure) => MeasureCard(measure: measure)),
              const SizedBox(height: 10),
              Text('between two different phases*',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              PhaseCard(phase: model.trial!.a, showSchedule: true),
              Center(
                child: Text('vs.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
              ),
              PhaseCard(phase: model.trial!.b, showSchedule: true),
              const SizedBox(height: 10),
              if (model.trial!.type == TrialType.alternatingTreatment)
                Text('to see if A or B is better for achieving your goal',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
              if (model.trial!.type == TrialType.reversal)
                Text(
                    'to see if there is a difference** between A or B for achieving your goal',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor)),
              GoalCard(
                goal: model.trial!.goal,
              ),
              const SizedBox(height: 20),
              Text(
                  '* For a good comparison, you will complete a series of the two phases and compare A and B multiple times.',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor)),
              const SizedBox(height: 20),
              if (model.trial!.type == TrialType.reversal)
                Text(
                    '** If there is no difference "${model.trial!.interventionA!.name}" likely doesn\'t help you achieve your goal.',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor)),
              const SizedBox(height: 30),
              Center(
                child: HighlightedActionButton(
                    icon: Icons.arrow_forward,
                    labelText: 'Schedule Experiment',
                    onPressed: () => _navigateToCreatorPhases(context, model)),
              ),
              const SizedBox(height: 60),
            ]),
          ),
        ),
      );
    });
  }

  void _navigateToCreatorPhases(BuildContext context, AppData model) {
    Provider.of<AppData>(context, listen: false)
        .addStepLogForSurvey('finish viewing setup');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreatorSchedule(),
      ),
    );
  }
}
