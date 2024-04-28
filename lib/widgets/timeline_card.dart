import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {
  final String text;
  final String? warningText;
  final String? subText;
  const TimelineCard(
      {super.key, required this.text, this.subText, this.warningText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 12),
          child: Text(text),
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(3, 0, 0, 255),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
