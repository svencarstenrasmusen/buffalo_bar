import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/data/services/buffalo_service.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/scalp_tile.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BuffaloService buffaloService = BuffaloService();
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
        body: Flexible(child: _buffaloListing()));
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
}
