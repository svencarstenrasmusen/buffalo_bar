import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/utils/constants.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: Constants.blurRadius,
            offset: Constants.blurOffset)
      ]),
      child: Placeholder(child: Text('${user.toString()}')),
    );
  }
}
