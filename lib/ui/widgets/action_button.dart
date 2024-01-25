import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final bool? canPress;
  final void Function() onPressed;

  const ActionButton(
      {Key? key, required this.icon, required this.canPress, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: canPress! ? () => onPressed() : null,
    );
  }
}
