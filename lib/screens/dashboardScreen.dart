import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/models/user.dart';
import 'package:buffalo_bar/data/providers/user_provider.dart';
import 'package:buffalo_bar/data/services/buffalo_service.dart';
import 'package:buffalo_bar/data/services/user_service.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/scalp_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/loadingIndicatorWithText.dart';

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
            if (snapshot.data!.isEmpty) {
              return noBuffaloesText();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: ScalpTile(scalp: snapshot.data![index]),
                    );
                  });
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error!}'));
          }
          return const CircularProgressIndicator();
        });
  }

  Center noBuffaloesText() {
    return const Center(
      child: Text('There seem to be no buffaloes... GO GET THEM!'),
    );
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirm Your Scalp!'),
                          content: Text(
                              'Are you sure want to buffalo: ${snapshot.data![index].username}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return _buffalo(
                                          snaggee: snapshot.data![index]);
                                    });
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      },
                    );
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

  FutureBuilder _buffalo({required User snaggee}) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return FutureBuilder(
      future:
          buffaloService.buffalo(scalperId: user!.id, snaggeeId: snaggee.id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AlertDialog(
            title: const Text('SUCCESS!'),
            content:
                const Icon(Icons.check_circle, color: Colors.green, size: 50),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: const Text("OH MERDE!"),
            content: Text('Error: ${snapshot.error!.toString()}'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        }
        return const AlertDialog(
          title: Text("BUFFALOING"),
          content: LoadingIndicatorWithText(text: 'This is taking a bit...'),
        );
      },
    );
  }
}
