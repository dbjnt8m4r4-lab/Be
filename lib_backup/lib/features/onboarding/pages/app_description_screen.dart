import 'package:flutter/material.dart';

class AppDescriptionScreen extends StatelessWidget {
  const AppDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Description'),
      ),
      body: const Center(
        child: Text('Welcome to our app!'),
      ),
    );
  }
}