import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: const Text(
          'AB News',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('This is home page'),
      ),
    );
  }
}
