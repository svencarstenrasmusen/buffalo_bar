import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/utils/constants.dart';
import 'package:flutter/material.dart';

class ScalpTile extends StatelessWidget {
  const ScalpTile({super.key, required this.scalp});

  final Buffalo scalp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: Constants.blurRadius,
            offset: Constants.blurOffset)
      ]),
      child: Placeholder(
          child: Text('${scalp.toString()} ${scalp.getDateTimeString()}')),
    );
  }
}
