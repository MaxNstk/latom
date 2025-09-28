
import 'package:flutter/material.dart';
import 'package:latom/core/preferences_manager.dart';
import 'package:latom/ui/pages/home_screen.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    
    return LtFutureBuilder(
      future: PreferencesManager.initPreferences(),
      builder: (PreferencesManager? prefs){
        return MaterialApp(
          title: 'Flutter Demo',
          theme: prefs!.getThemeData(),
          home: const HomePage(title: 'LATOM'),
        );
      },
    );
  }
}
