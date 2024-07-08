import 'package:buffalo_bar/data/providers/user_provider.dart';
import 'package:buffalo_bar/data/services/user_service.dart';
import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/buffalo_widget.dart';
import 'package:buffalo_bar/widgets/buttons/buffalo_button.dart';
import 'package:buffalo_bar/widgets/dialogs/not_implement.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: buffaloYellow,
      body: Center(
        child: userProvider.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: screenHeight / 2),
                      child: const BuffaloWidget()),
                  BuffaloButton(
                      text: 'Login',
                      onTap: () {
                        userProvider.loginAndSetUser(userService).then((_) {
                          if (userProvider.isLoggedIn) {
                            context.go('/dashboard');
                          }
                        });
                      })
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
