import 'package:flutter/material.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/ui/screens/measure_overview.dart';
import 'package:studyme/ui/widgets/measure_card.dart';

class CreatorMeasureSection extends StatelessWidget {
  final AppData model;

  const CreatorMeasureSection(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
            "Data collected to assess if what you are trying is helping you achieve your goal",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: model.trial!.measures!.length,
          itemBuilder: (context, index) {
            return MeasureCard(
                showSchedule: true,
                measure: model.trial!.measures![index],
                onTap: () {
                  _viewMeasure(context, index);
                });
          },
        ),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: Text(
                    'Add${model.trial!.measures!.isNotEmpty ? ' another' : ''}'),
                onPressed: () => _addMeasure(context)),
          ],
        ),
      ],
    );
  }

  _addMeasure(context) {
    Navigator.pushNamed(context, Routes.measure_library);
  }

  _viewMeasure(context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureOverview(index: index),
      ),
    );
  }
}
