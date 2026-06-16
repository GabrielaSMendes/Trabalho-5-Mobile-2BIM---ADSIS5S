import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../widgets/meal_card.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: favoritesAsync.when(
        data: (favorites) => favorites.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 72, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Nenhum favorito ainda.'),
                    SizedBox(height: 8),
                    Text(
                      'Toque no ♥ na tela de detalhes para salvar.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) => MealCard(
                  meal: favorites[index],
                  onTap: () => context.push(
                    '/detail/${favorites[index].id}'
                    '?name=${Uri.encodeComponent(favorites[index].name)}',
                  ),
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text('Erro ao carregar favoritos: $error')),
      ),
    );
  }
}
