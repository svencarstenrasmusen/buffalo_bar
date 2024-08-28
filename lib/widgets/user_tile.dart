import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/utils/constants.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {super.key,
      required this.user,
      required this.joinedAt,
      required this.isAdmin});

  final User user;
  final String joinedAt;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: Constants.blurRadius,
            offset: Constants.blurOffset)
      ]),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(user.username),
        subtitle: Text('Joined: $joinedAt'),
        trailing: isAdmin == true
            ? const Icon(Icons.verified_user, color: Colors.blue)
            : Container(),
      ),
    );
  }
}
