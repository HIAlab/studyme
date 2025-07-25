import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/measure/keyboard_measure.dart';
import 'package:studyme/models/measure/measure.dart';
import 'package:studyme/ui/screens/measure_editor_name.dart';
import 'package:studyme/ui/widgets/library_create_button.dart';
import 'package:studyme/ui/widgets/measure_card.dart';

import 'measure_preview.dart';

class MeasureLibrary extends StatelessWidget {
  const MeasureLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (context, model, child) {
      List<Measure> unaddedMeasures = model.unaddedMeasures;
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                  "What ${(model.trial!.measures!.isNotEmpty) ? 'other ' : ''}data do you want to collect to assess if you are achieving your goal?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
              LibraryCreateButton(onPressed: () => _createMeasure(context)),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: unaddedMeasures.length,
                  itemBuilder: (context, index) {
                    Measure measure = unaddedMeasures[index];
                    return MeasureCard(
                        measure: measure,
                        onTap: () => _previewMeasure(context, measure));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _previewMeasure(context, measure) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasurePreview(measure: measure),
      ),
    );
  }

  void _createMeasure(context) {
    saveFunction(Measure measure) {
      Provider.of<AppData>(context, listen: false).addMeasure(measure);
      Navigator.pushNamedAndRemoveUntil(context, '/creator', (r) => false);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureEditorName(
            measure: KeyboardMeasure(), onSave: saveFunction, save: false),
      ),
    );
  }
}
