
import 'package:flutter/material.dart';
import 'package:latom/core/preferences_manager.dart';
import 'package:latom/core/providers/theme_provider.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';
import 'package:provider/provider.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();

}

class _PreferencesScreenState extends State<PreferencesScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return LtFutureBuilder(
      future: PreferencesManager.initPreferences(),
      builder: (PreferencesManager? prefs) {
        return LtScaffold(
          title: 'PREFERENCES',
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButton(
                  items: [
                    DropdownMenuItem<String>(value: 'dark', child: Text('DARK'),),
                    DropdownMenuItem<String>(value: 'light', child: Text('LIGHT'),),
                  ], 
                  onChanged: (String? value) async {
                    if (value == null) return;
                    await prefs.setTheme(value);
                    themeProvider.setTheme(prefs.getThemeData());
                  },
                  value: prefs!.theme,
                )
              ],
            )
          ) 
        );
      } 
    );
  }

}