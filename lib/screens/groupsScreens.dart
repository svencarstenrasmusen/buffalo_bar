import 'package:buffalo_bar/data/models/group.dart';
import 'package:buffalo_bar/data/services/group_service.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/group_tile.dart';
import 'package:buffalo_bar/widgets/loadingIndicatorWithText.dart';
import 'package:flutter/material.dart';

class GroupsScreens extends StatefulWidget {
  const GroupsScreens({super.key});

  @override
  State<GroupsScreens> createState() => _GroupsScreensState();
}

class _GroupsScreensState extends State<GroupsScreens> {
  final GroupService groupService = GroupService();
  late Future<List<Group>> groups;

  @override
  void initState() {
    super.initState();
    groups = groupService.getAllJoinedGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buffaloYellow,
      body: _groupsListing(),
    );
  }

  FutureBuilder _groupsListing() {
    return FutureBuilder<List<Group>>(
      future: groups,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(5),
                  child: GroupTile(group: snapshot.data![index]));
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
}
