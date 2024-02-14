import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {
  final bool isActive;
  final Widget? cardChild;
  final Color? cardColor;
  final Widget? belowCardChild;

  const TimelineCard(
      {Key? key,
      this.isActive = false,
      this.cardChild,
      this.cardColor,
      this.belowCardChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(children: [
        SizedBox(
            height: 50,
            child: Card(
                shape: isActive
                    ? RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColor, width: 4.0),
                        borderRadius: BorderRadius.circular(4.0))
                    : null,
                color: cardColor,
                child: Center(child: cardChild))),
        if (belowCardChild != null) belowCardChild!
      ]),
    );
  }
}
