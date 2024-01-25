import 'package:flutter/material.dart';
import 'package:studyme/models/measure/scale_measure.dart';

class ScaleMeasureWidget extends StatefulWidget {
  final ScaleMeasure? measure;

  final void Function(num value)? updateValue;

  const ScaleMeasureWidget(this.measure, this.updateValue, {Key? key}) : super(key: key);

  @override
  ScaleMeasureWidgetState createState() => ScaleMeasureWidgetState();
}

class ScaleMeasureWidgetState extends State<ScaleMeasureWidget> {
  num? _state;

  @override
  void initState() {
    _state = widget.measure!.min;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          onChanged: (x) => setState(() {
            _state = x;
            if (widget.updateValue != null) {
              widget.updateValue!(x);
            }
          }),
          value: _state as double,
          min: widget.measure!.min!,
          max: widget.measure!.max!,
          label: _state!.round().toString(),
          divisions: (widget.measure!.max! - widget.measure!.min!).toInt(),
        ),
        Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.measure!.min!.toInt().toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.measure!.minLabel!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.measure!.max!.toInt().toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(widget.measure!.maxLabel!,
                            textAlign: TextAlign.right,
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ],
    );
  }
}
