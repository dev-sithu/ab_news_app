import 'package:flutter/material.dart';

AppBar titleBar(BuildContext context, String pageTitle) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    title: Text(
      pageTitle,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
