import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal.dart';
import '../providers/providers.dart';

class FavoriteButton extends ConsumerWidget {
  final String mealId;
  final Meal meal;

  const FavoriteButton({super.key, required this.mealId, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavAsync = ref.watch(isFavoriteProvider(mealId));

    return isFavAsync.when(
      data: (isFav) => IconButton(
        icon: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : null,
        ),
        tooltip: isFav ? 'Remover favorito' : 'Adicionar favorito',
        onPressed: () async {
          await ref.read(toggleFavoriteUseCaseProvider).call(meal);
          ref.invalidate(isFavoriteProvider(mealId));
          ref.invalidate(favoritesProvider);
        },
      ),
      loading: () => const SizedBox(
        width: 48,
        height: 48,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      error: (_, __) => const Icon(Icons.favorite_border),
    );
  }
}
