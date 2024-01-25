import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String _language = 'vi';
  String get language => _language;

  String _theme = 'light';
  String get theme => _theme;

  void updateLanguage(String newLanguage) {
    _language = newLanguage;
    notifyListeners();
  }

  void updateTheme(String newTheme) {
    _theme = newTheme;
    notifyListeners();
  }
}


