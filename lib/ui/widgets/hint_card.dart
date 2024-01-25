import 'package:flutter/material.dart';

class HintCard extends StatelessWidget {
  final String? titleText;
  final List<Widget>? body;
  final bool canClose;

  const HintCard({Key? key, this.titleText, this.body, this.canClose = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? title = titleText != null
        ? Text(titleText!, style: const TextStyle(fontWeight: FontWeight.bold))
        : null;
    return Card(
      color: Colors.blue[50],
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ListTile(
          leading: const Icon(
            Icons.info,
            color: Colors.blue,
            size: 32,
          ),
          trailing: canClose
              ? IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => print("hi"))
              : null,
          title: title,
        ),
        if (body != null)
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: body!))
      ]),
    );
  }
}
