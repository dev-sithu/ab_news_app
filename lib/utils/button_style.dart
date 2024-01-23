import 'package:flutter/material.dart';

ButtonStyle getPrimaryButtonStyle() {
  return TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blueAccent,
    padding: const EdgeInsets.all(20.0),
    textStyle: const TextStyle(fontSize: 20),
  );
}
