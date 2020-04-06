import 'package:flutter/material.dart';

class LikesCount extends StatelessWidget {
  final int _count;

  LikesCount(
    this._count,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Icon
        Icon(
          Icons.favorite,
          size: 20,
          color: Colors.green[300],
        ),
        // Spacer
        SizedBox(width: 8),
        // Count
        Text('$_count'),
      ],
    );
  }
}