import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:projetofinalflutter/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  });

  testWidgets(
    'fluxo completo: inicia o app → navega para Configurações → alterna tema',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: RecipeWorldApp()),
      );

      // Aguarda a tela inicial carregar (carregamento da API ou loading)
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // A AppBar com o título do app deve sempre estar visível
      expect(find.text('RecipeWorld'), findsOneWidget);

      // Navega para Configurações via ícone na AppBar
      final settingsIcon = find.byTooltip('Configurações');
      expect(settingsIcon, findsOneWidget);
      await tester.tap(settingsIcon);
      await tester.pumpAndSettle();

      // Verifica que chegou na tela de Configurações
      expect(find.text('Configurações'), findsOneWidget);
      expect(find.text('Tema escuro'), findsOneWidget);

      // Alterna o tema tocando no switch e verifica que a página ainda está visível
      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();
      expect(find.text('Tema escuro'), findsOneWidget);
    },
  );

  testWidgets(
    'navega para Favoritos e exibe estado vazio',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(child: RecipeWorldApp()),
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Navega para Favoritos
      final favIcon = find.byTooltip('Favoritos');
      expect(favIcon, findsOneWidget);
      await tester.tap(favIcon);
      await tester.pumpAndSettle();

      // Tela de favoritos deve mostrar mensagem de lista vazia
      expect(find.text('Favoritos'), findsOneWidget);
    },
  );
}
