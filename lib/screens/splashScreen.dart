import 'package:buffalo_bar/utils/colours.dart';
import 'package:buffalo_bar/widgets/loadingIndicatorWithText.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: buffaloYellow,
      body: Center(
        child: Expanded(
          child: LoadingIndicatorWithText(text: 'Loading Buffalo...'),
        ),
      ),
    );
  }
}
