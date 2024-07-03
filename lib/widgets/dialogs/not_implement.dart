import 'package:buffalo_bar/widgets/buttons/buffalo_button.dart';
import 'package:flutter/material.dart';

class NotImplementDialog extends StatelessWidget {
  const NotImplementDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.build_circle_outlined, size: 50),
          const SizedBox(height: 10),
          const Text('This feature is still under construction!',
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          BuffaloButton(text: 'Okay', onTap: Navigator.of(context).pop)
        ],
      ),
    );
  }
}
