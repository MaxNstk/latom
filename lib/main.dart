import 'package:flutter/material.dart';
import 'package:latom/app.dart';
import 'package:latom/core/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const App()
    )
  );
}

