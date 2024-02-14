import 'package:flutter/material.dart';
import 'package:studyme/models/intervention.dart';

class InterventionCard extends StatelessWidget {
  final Intervention? intervention;
  final bool showSchedule;
  final void Function()? onTap;

  const InterventionCard(
      {Key? key, this.intervention, this.onTap, this.showSchedule = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(intervention!.name!),
      subtitle: _getSubtitle(),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    ));
  }

  _getSubtitle() {
    if (showSchedule && intervention!.schedule != null) {
      return Text(intervention!.schedule!.readable);
    } else {
      return null;
    }
  }
}
