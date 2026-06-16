import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

class PreferencesDataSource {
  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.themeKey) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.themeKey, value);
  }
}
