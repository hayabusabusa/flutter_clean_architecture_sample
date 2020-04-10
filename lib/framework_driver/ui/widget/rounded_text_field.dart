import 'dart:ffi';

import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmited;

  RoundedTextField({
    this.controller,
    this.hintText,
    this.onEditingComplete,
    this.onSubmited,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Icon
          Icon(Icons.search),
          // Spacer
          SizedBox(width: 8,),
          // TextField
          Expanded(
            child: TextField(
              controller: controller,
              onEditingComplete: onEditingComplete,
              onSubmitted: onSubmited,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                )
              ),
            ),
          ),
        ],
      )
    );
  }
}