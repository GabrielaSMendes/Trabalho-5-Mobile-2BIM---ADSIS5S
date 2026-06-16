import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tema escuro'),
            subtitle: const Text('Alterna entre tema claro e escuro'),
            secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            value: isDark,
            onChanged: (_) => ref.read(themeProvider.notifier).toggle(),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('RecipeWorld'),
            subtitle: Text('v1.0.0 — Atividade Final Mobile\nTheMealDB API'),
          ),
        ],
      ),
    );
  }
}
