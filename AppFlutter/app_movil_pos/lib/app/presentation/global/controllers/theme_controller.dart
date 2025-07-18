import 'package:flutter/material.dart';

import '../../../domain/repositories/preferences_repository.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(
    this._darkMode, {
    required this.preferencesRepository,
  });

  final PreferencesRepository preferencesRepository;
  bool _darkMode;
  bool get dartMode => _darkMode;

  void onChanged(bool darkMode) {
    _darkMode = darkMode;
    preferencesRepository.setDarkMode(_darkMode);
    notifyListeners();
  }
}
