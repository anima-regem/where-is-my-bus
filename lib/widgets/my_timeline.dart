import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:where_is_my_bus/widgets/timeline_card.dart';

class MyTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  const MyTimelineTile(
      {super.key,
      required this.isFirst,
      required this.isLast,
      required this.isPast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast ? Colors.blue : Colors.blue.shade100,
          thickness: 7,
        ),
        indicatorStyle: IndicatorStyle(
          width: 25,
          color: isPast ? Colors.blue : Colors.blue.shade100,
          iconStyle: IconStyle(
            iconData: Icons.check,
            color: isPast ? Colors.white : Colors.blue.shade100,
          ),
        ),
        endChild: TimelineCard(text: "Hello from me too"),
      ),
    );
  }
}
