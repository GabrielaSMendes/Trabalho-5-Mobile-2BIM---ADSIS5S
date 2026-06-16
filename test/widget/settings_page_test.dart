import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/data/datasources/local/preferences_datasource.dart';
import 'package:projetofinalflutter/presentation/pages/settings_page.dart';
import 'package:projetofinalflutter/presentation/providers/theme_provider.dart';

// Stub que nunca chama SharedPreferences de verdade
class FakePreferences extends Fake implements PreferencesDataSource {
  bool _dark = false;

  @override
  Future<bool> getDarkMode() async => _dark;

  @override
  Future<void> setDarkMode(bool value) async => _dark = value;
}

ProviderScope buildTestApp(FakePreferences fakePrefs) {
  return ProviderScope(
    overrides: [
      preferencesDataSourceProvider.overrideWithValue(fakePrefs),
    ],
    // MaterialApp sem router: Go Router não é necessário para renderização
    child: const MaterialApp(home: SettingsPage()),
  );
}

void main() {
  testWidgets('exibe o SwitchListTile de tema escuro', (tester) async {
    await tester.pumpWidget(buildTestApp(FakePreferences()));
    await tester.pump(); // aguarda _load() async do ThemeNotifier

    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.text('Tema escuro'), findsOneWidget);
  });

  testWidgets('switch começa desligado (tema claro por padrão)', (tester) async {
    await tester.pumpWidget(buildTestApp(FakePreferences()));
    await tester.pump();

    final switchWidget =
        tester.widget<SwitchListTile>(find.byType(SwitchListTile));
    expect(switchWidget.value, isFalse);
  });

  testWidgets('toggle do switch altera o estado do tema', (tester) async {
    final fakePrefs = FakePreferences();
    await tester.pumpWidget(buildTestApp(fakePrefs));
    await tester.pump();

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    final switchWidget =
        tester.widget<SwitchListTile>(find.byType(SwitchListTile));
    expect(switchWidget.value, isTrue);
  });
}
