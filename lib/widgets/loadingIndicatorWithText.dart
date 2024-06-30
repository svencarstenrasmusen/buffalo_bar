import 'package:flutter/material.dart';

class LoadingIndicatorWithText extends StatelessWidget {
  final String text;
  const LoadingIndicatorWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 5),
        Text(text)
      ],
    );
  }
}
