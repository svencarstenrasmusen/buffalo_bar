import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/utils/constants.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile(
      {super.key,
      required this.user,
      required this.joinedAt,
      required this.isAdmin,
      required this.scalps,
      required this.snags,
      required this.position});

  final User user;
  final String joinedAt;
  final bool isAdmin;
  final int position;
  final int scalps;
  final int snags;

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
        leading: position > 1
            ? Text(position.toString())
            : const Icon(Icons.military_tech),
        title: _nameAndStats(),
        subtitle: Text('Joined: $joinedAt'),
        trailing: isAdmin == true
            ? const Icon(Icons.verified_user, color: Colors.blue)
            : Container(),
      ),
    );
  }

  Row _nameAndStats() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(flex: 2, child: Text(user.username)),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Text('Scalps: '),
              Text(scalps.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Text('Snags: '),
              Text(snags.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ],
    );
  }
}
