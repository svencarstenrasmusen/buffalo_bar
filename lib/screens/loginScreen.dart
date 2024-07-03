import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/buffalo_widget.dart';
import 'package:buffalo_bar/widgets/buttons/buffalo_button.dart';
import 'package:buffalo_bar/widgets/dialogs/not_implement.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: buffaloYellow,
        body: Column(
          children: [
            const BuffaloWidget(),
            BuffaloButton(text: 'Login', onTap: _login)
          ],
        ));
  }

  void _login() {
    showDialog(
        context: context, builder: (context) => const NotImplementDialog());
  }
}
