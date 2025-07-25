import 'package:flutter/material.dart';
import 'package:studyme/models/measure/measure.dart';

class MeasureCard extends StatelessWidget {
  final Measure? measure;
  final bool showSchedule;
  final void Function()? onTap;

  const MeasureCard(
      {super.key, this.measure, this.onTap, this.showSchedule = false});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(measure!.getIcon()),
      title: Text(measure!.name!),
      subtitle: _getSubtitle(),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    ));
  }

  Text? _getSubtitle() {
    if (showSchedule && measure!.schedule != null) {
      return Text(measure!.schedule!.readable);
    } else {
      return null;
    }
  }
}
