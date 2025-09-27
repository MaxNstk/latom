
import 'package:flutter/material.dart';
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
    return LtScaffold(
      title: 'PREFERENCES',
      body: Form(
        key: _formKey,
        child: Column(
          children: [],
        )
      ) 
    );
  }

}