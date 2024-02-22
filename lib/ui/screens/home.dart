import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/log_data.dart';
import 'package:studyme/models/phase/phase.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/hint_card.dart';
import 'package:studyme/ui/widgets/phase_card.dart';
import 'package:studyme/ui/widgets/task_list.dart';
import 'package:studyme/ui/widgets/trial_schedule_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // listen to log data so screen is rebuilt when logs are added
    Provider.of<LogData>(context);
    final Trial trial = Provider.of<AppData>(context).trial!;
    final dateToday = DateTime.now().add(const Duration(days: 0));

    Widget body;
    int activeIndex;

    if (dateToday.isBefore(trial.startDate!)) {
      body = _buildBeforeStartBody(trial);
      activeIndex = -1;
    } else if (dateToday.isAfter(trial.endDate)) {
      body = _buildAfterEndBody(trial);
      activeIndex = trial.schedule!.totalDuration;
    } else {
      body = _buildActiveBody(context, trial, dateToday);
      activeIndex = trial.getPhaseIndexForDate(dateToday);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TrialScheduleWidget(
              schedule: trial.schedule!, activeIndex: activeIndex),
          body,
        ]),
      ),
    );
  }

  _buildActiveBody(BuildContext context, Trial trial, DateTime date) {
    Phase? phase = trial.getPhaseForDate(date);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (phase != null) PhaseCard(phase: phase),
      const SizedBox(height: 20),
      Text('Today',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor)),
      TaskList(trial: trial, date: date),
    ]);
  }

  _buildBeforeStartBody(Trial trial) {
    return Column(children: [
      const SizedBox(height: 20),
      HintCard(titleText: "Experiment hasn't started yet", body: [
        Text(
            "Your experiment will start on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(trial.startDate!)}")
      ])
    ]);
  }

  _buildAfterEndBody(Trial trial) {
    return Column(children: [
      const SizedBox(height: 20),
      HintCard(titleText: "Experiment ended", body: [
        Text(
            "Your experiment ended on ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(trial.endDate)}")
      ])
    ]);
  }
}
