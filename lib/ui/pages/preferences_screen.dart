
import 'package:flutter/material.dart';
import 'package:latom/core/preferences_manager.dart';
import 'package:latom/ui/widgets/lt_future_builder.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();

}

class _PreferencesScreenState extends State<PreferencesScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return LtFutureBuilder(
      future: PreferencesManager.initPreferences(),
      nullResponseMsg: 'Nothing to Show',
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
                    setState(()=>{});
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