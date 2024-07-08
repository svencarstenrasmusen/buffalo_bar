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
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: buffaloYellow,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screenHeight / 2),
                child: const BuffaloWidget()),
            BuffaloButton(text: 'Login', onTap: _login)
          ],
        ),
      ),
    );
  }

  void _login() {
    showDialog(
        context: context, builder: (context) => const NotImplementDialog());
  }
}
