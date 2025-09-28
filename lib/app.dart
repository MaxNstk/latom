
import 'package:flutter/material.dart';
import 'package:latom/core/preferences_manager.dart';
import 'package:latom/core/providers/theme_provider.dart';
import 'package:latom/ui/pages/home_screen.dart';
import 'package:latom/ui/widgets/loading_widget.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return LtFutureBuilder(
      future: PreferencesManager.initPreferences(),
      builder: (PreferencesManager? prefs){
        if (prefs == null){
          return LtLoadingWidget();
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeProvider.themeData,
          home: const HomePage(title: 'LATOM'),
        );
      },
    );
  }
}
