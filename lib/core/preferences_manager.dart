import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {

  static const defaultTheme = 'dark';
  String theme = defaultTheme;

  final SharedPreferencesAsync _prefsHandler = SharedPreferencesAsync();
  
  static Future<PreferencesManager> initPreferences() async {
    PreferencesManager prefs = PreferencesManager();
    await prefs.initTheme();
    return prefs;
  }

  Future<void> initTheme() async {
    String? storedTheme = await _prefsHandler.getString('theme');
    storedTheme ??= defaultTheme;
    await setTheme(storedTheme);
  }

  ThemeData getThemeData() {
    if(theme == 'dark'){
      return ThemeData.dark();
    } 
    else {
      return ThemeData.light(); 
    }
  }

  Future<void> setTheme(String newTheme) async {
    await _prefsHandler.setString('theme', newTheme);
    theme = newTheme;
  }
}