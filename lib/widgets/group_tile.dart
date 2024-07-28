import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/utils/constants.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.group});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: Constants.blurRadius,
            offset: Constants.blurOffset)
      ]),
      child: Placeholder(child: Text(group.toString())),
    );
  }
}
