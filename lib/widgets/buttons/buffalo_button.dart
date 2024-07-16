import 'package:flutter/material.dart';

class BuffaloButton extends StatelessWidget {
  const BuffaloButton({super.key, required this.text, this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(text));
  }
}
