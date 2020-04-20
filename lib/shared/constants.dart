import 'package:flutter/material.dart';

final textInputDecor = InputDecoration(
  hintStyle: TextStyle(color: Color.fromARGB(255, 255, 232, 131)),
  filled: true,
  fillColor: Colors.black,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0)),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 255, 232, 131), width: 2.0),
  ),
);
