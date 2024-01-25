import 'package:flutter/material.dart';

class HighlightedActionButton extends StatelessWidget {
  final IconData icon;
  final String labelText;
  final Function()? onPressed;

  const HighlightedActionButton(
      {Key? key, required this.icon,
      required this.labelText,
      required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          labelText,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        onPressed: onPressed);
  }
}
