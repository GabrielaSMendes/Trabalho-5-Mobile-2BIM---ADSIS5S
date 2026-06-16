import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/preferences_datasource.dart';

final preferencesDataSourceProvider =
    Provider<PreferencesDataSource>((_) => PreferencesDataSource());

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier(ref.watch(preferencesDataSourceProvider));
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final PreferencesDataSource _prefs;

  ThemeNotifier(this._prefs) : super(ThemeMode.light) {
    _load();
  }

  Future<void> _load() async {
    final isDark = await _prefs.getDarkMode();
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggle() async {
    final isDark = state == ThemeMode.dark;
    await _prefs.setDarkMode(!isDark);
    state = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}
