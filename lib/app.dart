
import 'package:flutter/material.dart';
import 'package:latom/ui/pages/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const HomePage( title: 'LATOM'),
    );
  }
}
