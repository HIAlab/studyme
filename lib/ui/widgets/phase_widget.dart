import 'package:flutter/material.dart';
import 'package:studyme/models/trial.dart';
import 'package:studyme/ui/widgets/timeline.dart';

class PhaseWidget extends StatelessWidget {
  final Trial? trial;

  const PhaseWidget({Key? key, this.trial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timeline(
        activeIndex: 0,
        height: 50,
        itemCount: 0,
        callback: (index) {
          return const Text("hi");
        });
  }
}
