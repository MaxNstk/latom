import 'package:flutter/material.dart';


class LtScaffold extends StatelessWidget {
  
  final Widget body;
  final String title;
  final FloatingActionButton? floatingActionButton;

  const LtScaffold({super.key, required this.body, required this.title, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}