import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/enums.dart';
import '../../domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  PreferencesRepositoryImpl(this._preferences);
  final SharedPreferences _preferences;

  @override
  bool? get darkMode {
    return _preferences.getBool(Preference.darkMode.name);
  }

  @override
  Future<void> setDarkMode(bool darkMode) async {
    await _preferences.setBool(Preference.darkMode.name, darkMode);
  }
}
