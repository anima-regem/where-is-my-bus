import 'package:flutter/material.dart';
import 'package:where_is_my_bus/widgets/my_timeline.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: ListView(
          children: [
            MyTimelineTile(isFirst: true, isLast: false, isPast: true),
            MyTimelineTile(isFirst: false, isLast: false, isPast: true),
            MyTimelineTile(isFirst: false, isLast: false, isPast: true),
            MyTimelineTile(isFirst: false, isLast: false, isPast: true),
            MyTimelineTile(isFirst: false, isLast: false, isPast: true),
            MyTimelineTile(isFirst: false, isLast: false, isPast: true),
            MyTimelineTile(isFirst: false, isLast: false, isPast: false),
            MyTimelineTile(isFirst: false, isLast: false, isPast: false),
            MyTimelineTile(isFirst: false, isLast: false, isPast: false),
            MyTimelineTile(isFirst: false, isLast: true, isPast: false),
          ],
        ),
      ),
    ));
  }
}
