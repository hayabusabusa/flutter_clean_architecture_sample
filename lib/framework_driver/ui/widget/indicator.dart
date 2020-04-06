import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]),
    );
  }
}