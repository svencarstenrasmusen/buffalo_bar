import 'package:buffalo_bar/utils/colours.dart';
import 'package:flutter/material.dart';

class BuffaloWidget extends StatelessWidget {
  /// Creates a Buffalo widget to display the Buffalo logo.
  /// The Buffalo widget will take the maximum amount of space available to it.
  /// The [icon] parameter allows for a custom Icon to be added.

  const BuffaloWidget({super.key, Icon? icon})
      : icon = icon ?? const Icon(Icons.question_mark);

  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxRadius = constraints.biggest.shortestSide / 2;
      double innerRadius = maxRadius * 0.8;
      return CircleAvatar(
        radius: maxRadius,
        backgroundColor: buffaloRed,
        child: CircleAvatar(
          radius: innerRadius,
          backgroundColor: buffaloOrange,
          child: icon,
        ),
      );
    });
  }
}
