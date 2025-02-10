
import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  fillColor: Colors.white38,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0
    )
  ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.pink,
            width: 2.0
        )
    )
);