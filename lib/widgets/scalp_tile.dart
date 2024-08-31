import 'package:buffalo_bar/data/models/buffalo.dart';
import 'package:buffalo_bar/utils/constants.dart';
import 'package:flutter/material.dart';

class ScalpTile extends StatelessWidget {
  const ScalpTile({super.key, required this.scalp});

  final Buffalo scalp;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.black,
            blurRadius: Constants.blurRadius,
            offset: Constants.blurOffset)
      ]),
      child: ListTile(
        title: _buffaloContent(),
        subtitle: Text(scalp.getDateTimeString()),
      ),
    );
  }

  Row _buffaloContent() {
    return Row(
      children: [
        Expanded(flex: 2, child: _scalperText()),
        Expanded(
          flex: 2,
          child: _snaggeeText(),
        )
      ],
    );
  }

  Row _scalperText() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Scalper: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(scalp.scalper.username)
      ],
    );
  }

  Row _snaggeeText() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Scalp: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(scalp.snaggee.username)
      ],
    );
  }
}
