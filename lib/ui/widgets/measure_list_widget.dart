import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studyme/models/measure/list_measure.dart';
import 'package:studyme/ui/widgets/choice_card.dart';

class ListMeasureWidget extends StatefulWidget {
  final ListMeasure? measure;

  final void Function(num value)? updateValue;

  const ListMeasureWidget(this.measure, this.updateValue, {super.key});

  @override
  ListMeasureWidgetState createState() => ListMeasureWidgetState();
}

class ListMeasureWidgetState extends State<ListMeasureWidget> {
  num? _state;

  @override
  void initState() {
    _state = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.measure!.items!.length,
          itemBuilder: (context, index) {
            return ChoiceCard<num>(
                value: index,
                selectedValue: _state,
                title: Text('${widget.measure!.items![index].value}',
                    style: const TextStyle(fontSize: 20)),
                onSelect: _updateValue);
          }),
    );
  }

  void _updateValue(num value) {
    setState(() {
      _state = value;
    });
    if (widget.updateValue != null) {
      widget.updateValue!(_state!);
    }
  }
}
