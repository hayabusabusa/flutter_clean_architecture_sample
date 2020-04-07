import 'package:flutter/material.dart';

class RippleCard extends StatelessWidget {
  final Widget child;
  final double height;
  final Function onTap;

  const RippleCard({
    Key key,
    this.child,
    this.height,
    this.onTap,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(4, 4)
          )
        ]
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: child
        ),
      ),
    );
  }
}