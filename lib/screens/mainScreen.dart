import 'package:buffalo_bar/screens/dashboardScreen.dart';
import 'package:buffalo_bar/screens/groupsScreens.dart';
import 'package:flutter/material.dart';

import '../utils/colours.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _selectedPage(),
        bottomNavigationBar: NavigationBar(
            indicatorColor: buffaloYellow,
            backgroundColor: Colors.white,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.groups), label: 'Group'),
              NavigationDestination(
                  icon: Icon(Icons.account_circle), label: 'Profile'),
            ],
            selectedIndex: _currentPageIndex,
            onDestinationSelected: (int index) {
              _updateCurrentPageIndex(index);
            }));
  }

  Widget _selectedPage() {
    return [
      const DashboardScreen(),
      const GroupsScreens(),
      const Placeholder()
    ][_currentPageIndex];
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }
}
