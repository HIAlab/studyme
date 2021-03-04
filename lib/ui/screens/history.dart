import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/aggregations.dart';
import 'package:studyme/ui/widgets/intervention_card.dart';
import 'package:studyme/ui/widgets/measure_chart.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  TimeAggregation _timeAggregation;

  @override
  initState() {
    super.initState();
    _timeAggregation = TimeAggregation.Day;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, appState, child) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InterventionCard(phase: appState.trial.a),
              InterventionCard(phase: appState.trial.b),
              DropdownButtonFormField<TimeAggregation>(
                decoration: InputDecoration(labelText: 'Aggregate by'),
                value: _timeAggregation,
                onChanged: _changeTimeAggregation,
                items: [
                  TimeAggregation.Day,
                  TimeAggregation.Phase,
                  TimeAggregation.Intervention
                ].map<DropdownMenuItem<TimeAggregation>>((value) {
                  return DropdownMenuItem<TimeAggregation>(
                    value: value,
                    child: Text(value.readable),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: appState.trial.measures.length,
                  itemBuilder: (context, index) {
                    return MeasureChart(
                      measure: appState.trial.measures[index],
                      trial: appState.trial,
                      timeAggregation: _timeAggregation,
                    );
                  }),
              SizedBox(height: 120)
            ],
          ),
        ),
      );
    });
  }

  _changeTimeAggregation(TimeAggregation selectedAggregation) {
    setState(() {
      _timeAggregation = selectedAggregation;
    });
  }
}
