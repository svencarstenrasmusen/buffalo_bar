import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/services/buffalo_service.dart';
import 'package:buffalo_bar/data/services/user_service.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/scalp_tile.dart';
import 'package:flutter/material.dart';

import '../widgets/dialogs/not_implement.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BuffaloService buffaloService = BuffaloService();
  final UserService userService = UserService();
  late Future<List<Buffalo>> buffaloes;

  @override
  void initState() {
    super.initState();
    buffaloes = buffaloService.getAllBuffaloes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: buffaloYellow,
        body: _buffaloListing(),
        floatingActionButton: _addScalpButton());
  }

  FutureBuilder _buffaloListing() {
    return FutureBuilder<List<Buffalo>>(
        future: buffaloes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ScalpTile(scalp: snapshot.data![index]),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error!}'));
          }
          return const CircularProgressIndicator();
        });
  }

  FloatingActionButton _addScalpButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Buffalo!!!'),
                content:
                    SizedBox(height: 500, width: 500, child: _getAllPlayers()),
              );
            });
      },
      child: const Icon(Icons.add),
    );
  }

  FutureBuilder _getAllPlayers() {
    return FutureBuilder<List<User>>(
        future: userService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].username),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    _buffalo(scalper: 'example', snaggee: 'example2');
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error!.toString()}');
          }
          return const CircularProgressIndicator();
        });
  }

  void _buffalo({required String scalper, snaggee}) {
    print('$scalper is buffaloing $snaggee');
  }
}
