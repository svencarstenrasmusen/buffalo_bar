import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/buffalo_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: buffaloYellow,
      body: BuffaloWidget(),
    );
  }
}
