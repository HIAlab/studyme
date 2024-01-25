import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/phase_order.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/ui/widgets/action_button.dart';
import 'package:studyme/ui/widgets/trial_schedule_widget.dart';
import 'package:studyme/util/util.dart';

class TrialScheduleEditor extends StatefulWidget {
  const TrialScheduleEditor({Key? key}) : super(key: key);

  @override
  _TrialScheduleEditorState createState() => _TrialScheduleEditorState();
}

class _TrialScheduleEditorState extends State<TrialScheduleEditor> {
  TrialSchedule? _phases;

  @override
  void initState() {
    final trial = Provider.of<AppData>(context, listen: false).trial!;
    if (trial.schedule != null) {
      _phases = trial.schedule!.clone();
    } else {
      _phases = TrialSchedule.createDefault();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            ActionButton(
                icon: Icons.check, canPress: _canSubmit(), onPressed: _onSubmit)
          ], systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<AppData>(builder: (context, model, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edit trial schedule and phases",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor)),
                  const SizedBox(height: 10),
                  TrialScheduleWidget(schedule: _phases, showDuration: true),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _phases!.phaseDuration.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: _updatePhaseDuration,
                    decoration:
                        const InputDecoration(labelText: 'Phase Duration (in days)'),
                  ),
                  const SizedBox(width: 5),
                  TextFormField(
                    initialValue: _phases!.numberOfPhasePairs.toString(),
                    keyboardType: TextInputType.number,
                    onChanged: _updateNumberOfCycles,
                    decoration:
                        const InputDecoration(labelText: 'Number of Phase Pairs'),
                  ),
                  const SizedBox(width: 5),
                  const SizedBox(height: 30),
                  const Text('Advanced Settings',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<PhaseOrder>(
                    decoration: const InputDecoration(labelText: 'Phase Order'),
                    value: _phases!.phaseOrder,
                    onChanged: _updatePhaseOrder,
                    items: [PhaseOrder.alternating, PhaseOrder.counterbalanced]
                        .map<DropdownMenuItem<PhaseOrder>>((value) {
                      return DropdownMenuItem<PhaseOrder>(
                        value: value,
                        child: Text(value.readable),
                      );
                    }).toList(),
                  )
                ],
              );
            }),
          ),
        ));
  }

  _canSubmit() {
    return _phases!.totalDuration > 0 &&
        _phases!.totalDuration < 1000 &&
        _phases!.phaseDuration! <= 365 &&
        _phases!.numberOfPhasePairs! < 100;
  }

  _onSubmit() {
    Provider.of<AppData>(context, listen: false).updateSchedule(_phases);
    Navigator.pop(context, true);
  }

  _updateNumberOfCycles(text) {
    textToIntSetter(text, (int number) {
      setState(() {
        _phases!.updateNumberOfCycles(number);
      });
    });
  }

  _updatePhaseDuration(text) {
    textToIntSetter(text, (int number) {
      setState(() {
        _phases!.phaseDuration = number;
      });
    });
  }

  _updatePhaseOrder(phaseOrder) {
    setState(() {
      _phases!.updatePhaseOrder(phaseOrder);
    });
  }
}
