import 'package:buffalo_bar/utils/colours.dart';
import 'package:flutter/material.dart';

class BuffaloWidget extends StatelessWidget {
  /// Creates a Buffalo widget to display the Buffalo logo.
  /// The Buffalo widget will take the maximum amount of space available to it.
  /// The [icon] parameter allows for a custom Icon to be added.

  const BuffaloWidget(
      {super.key, Icon? icon, Color? outerColor, Color? innerColor})
      : icon = icon ?? const Icon(Icons.question_mark),
        outerColor = outerColor ?? buffaloDarkRed,
        innerColor = innerColor ?? buffaloOrange;

  final Icon icon;
  final Color outerColor;
  final Color innerColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxRadius = constraints.biggest.shortestSide / 2;
      double innerRadius = maxRadius * 0.8;
      return CircleAvatar(
        radius: maxRadius,
        backgroundColor: outerColor,
        child: CircleAvatar(
          radius: innerRadius,
          backgroundColor: innerColor,
          child: icon,
        ),
      );
    });
  }
}
