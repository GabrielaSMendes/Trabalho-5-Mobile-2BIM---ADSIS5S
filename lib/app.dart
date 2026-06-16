import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'presentation/pages/detail_page.dart';
import 'presentation/pages/favorites_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/meals_page.dart';
import 'presentation/pages/settings_page.dart';
import 'presentation/providers/theme_provider.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/meals/:category',
      builder: (context, state) =>
          MealsPage(category: state.pathParameters['category']!),
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) => DetailPage(
        mealId: state.pathParameters['id']!,
        mealName: state.uri.queryParameters['name'] ?? '',
      ),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

class RecipeWorldApp extends ConsumerWidget {
  const RecipeWorldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'RecipeWorld',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      routerConfig: _router,
    );
  }
}
