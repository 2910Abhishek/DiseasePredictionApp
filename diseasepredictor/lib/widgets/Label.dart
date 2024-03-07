import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  LabelWidget({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Text(
        label,
        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        textAlign: TextAlign.start,
      ),
    );
  }
}
