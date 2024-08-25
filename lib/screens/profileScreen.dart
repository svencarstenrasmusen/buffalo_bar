import 'package:buffalo_bar/data/providers/user_provider.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: buffaloYellow, body: _profile());
  }

  Widget _profile() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider(color: buffaloDarkRed, height: 4)),
            CircleAvatar(radius: 100, child: Icon(Icons.person)),
            Expanded(child: Divider(color: buffaloDarkRed, height: 4))
          ],
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Text('Username: ${userProvider.user?.username}'),
            const SizedBox(height: 5),
            Text('Email: ${userProvider.user?.email}'),
            const SizedBox(height: 5),
            Text('Joined Buffalo: ${userProvider.user?.getCreateDate()}'),
            const SizedBox(height: 50),
            Text('ID: ${userProvider.user?.id}'),
            const SizedBox(height: 5)
          ],
        )
      ],
    );
  }
}
