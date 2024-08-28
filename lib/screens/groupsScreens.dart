import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/providers/user_provider.dart';
import 'package:buffalo_bar/data/services/group_service.dart';
import 'package:buffalo_bar/data/services/user_service.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/group_tile.dart';
import 'package:buffalo_bar/widgets/loadingIndicatorWithText.dart';
import 'package:buffalo_bar/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsScreens extends StatefulWidget {
  const GroupsScreens({super.key});

  @override
  State<GroupsScreens> createState() => _GroupsScreensState();
}

class _GroupsScreensState extends State<GroupsScreens> {
  //Services
  final GroupService _groupService = GroupService();
  final UserService _userService = UserService();

  //Page variables
  Group? _selectedGroup;

  @override
  void initState() {
    super.initState();
    _selectedGroup = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: buffaloYellow,
        body:
            _selectedGroup != null ? _displaySelectedGroup() : _groupsListing()
        //body: _displayTooLazyText()
        );
  }

  Widget _displayTooLazyText() {
    return const Column(
      children: [
        Flexible(
          child: Center(
              child: Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  "The first season of Buffalo is a wild west! Go all out! No groups! You are live to everyone!!!")),
        ),
        Spacer(),
        Center(
            child: Text(
                "My dude... chill! I've got a life. Groups will be there soon.")),
        SizedBox(height: 20)
      ],
    );
  }

  Widget _displaySelectedGroup() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: _groupDetailHeading(name: _selectedGroup!.name),
      ),
      Flexible(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: _userListing(),
      )),
      Text(_selectedGroup.toString())
    ]);
  }

  FutureBuilder _userListing() {
    return FutureBuilder<List<User>>(
        future: _groupService.getAllPlayersFromGroupId(id: _selectedGroup!.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _listing(users: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error!.toString()));
          } else {
            return const LoadingIndicatorWithText(text: 'Loading Users...');
          }
        });
  }

  ListView _listing({required List<User> users}) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: UserTile(
              user: users[index], joinedAt: '21.08.2024', isAdmin: true),
        );
      },
    );
  }

  Widget _groupDetailHeading({required String name}) {
    return Row(
      children: [
        const Flexible(child: Divider(color: Colors.black)),
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 49,
            backgroundColor: buffaloYellow,
            child: Text(name, style: const TextStyle(color: Colors.white)),
          ),
        ),
        const Flexible(child: Divider(color: Colors.black))
      ],
    );
  }

  FutureBuilder _groupsListing() {
    return FutureBuilder<List<Group>>(
      future: _groupService.getAllJoinedGroups(
          id: Provider.of<UserProvider>(context, listen: false).user!.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: GroupTile(
                  group: snapshot.data![index],
                  onTap: () => printTap(group: snapshot.data![index]),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error!.toString());
        } else {
          return const LoadingIndicatorWithText(text: 'Loading Groups...');
        }
      },
    );
  }

  void printTap({required Group group}) {
    setState(() {
      _selectedGroup = group;
    });
  }
}
