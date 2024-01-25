import 'package:flutter/material.dart';
import 'package:studyme/models/trial_schedule.dart';
import 'package:studyme/ui/widgets/intervention_letter.dart';
import 'package:studyme/ui/widgets/timeline.dart';
import 'package:studyme/ui/widgets/timeline_card.dart';
import 'package:studyme/util/color_map.dart';

class TrialScheduleWidget extends StatefulWidget {
  final TrialSchedule? schedule;
  final bool showDuration;
  final bool showExplanation;
  final int activeIndex;

  TrialScheduleWidget(
      {required this.schedule,
      this.showDuration = false,
      this.showExplanation = false,
      this.activeIndex = -1});

  @override
  _TrialScheduleWidgetState createState() => _TrialScheduleWidgetState();
}

class _TrialScheduleWidgetState extends State<TrialScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Timeline(
            activeIndex: widget.activeIndex,
            height: widget.showDuration ? 71 : 50,
            itemCount: widget.schedule!.numberOfPhases + 1,
            callback: (int index) {
              Widget _cardContent;
              Widget? _textBelowCard;
              Color? _cardColor = Colors.white;

              if (index == widget.schedule!.numberOfPhases) {
                _cardContent = Icon(Icons.flag);
                if (widget.showDuration) {
                  _textBelowCard = _buildTotalDurationText();
                }
              } else {
                String letter = widget.schedule!.phaseSequence![index];
                _cardContent = InterventionLetter(letter,
                    isInverted: index < widget.activeIndex);
                if (widget.showDuration) {
                  _textBelowCard = _buildPhaseDurationText();
                }
                if (index < widget.activeIndex) {
                  _cardColor = letterColorMap[letter];
                }
              }

              return TimelineCard(
                  isActive: index == widget.activeIndex,
                  cardChild: _cardContent,
                  cardColor: _cardColor,
                  belowCardChild: _textBelowCard);
            }),
      ],
    );
  }

  _buildTotalDurationText() {
    return Text(
      '= ${widget.schedule!.phaseDuration! * widget.schedule!.numberOfPhases}d',
      style: TextStyle(fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    );
  }

  _buildPhaseDurationText() {
    return Text((widget.schedule!.phaseDuration.toString() + 'd'),
        overflow: TextOverflow.ellipsis);
  }
}
