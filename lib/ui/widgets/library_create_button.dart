import 'package:flutter/material.dart';
import 'package:studyme/ui/widgets/hightlighted_action_button.dart';

class LibraryCreateButton extends StatelessWidget {
  final Function()? onPressed;

  const LibraryCreateButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          HighlightedActionButton(
              icon: Icons.add,
              labelText: 'Create your own',
              onPressed: onPressed),
          Text('or select existing:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).primaryColor)),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
