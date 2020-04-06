import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  final String _imageURL;

  UserIcon(
    this._imageURL,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.all(Radius.circular(28)),
        image: DecorationImage(
          image: NetworkImage(_imageURL),
        ),
      ),
    );
  }
}