import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/meal.dart';
import '../providers/providers.dart';
import '../widgets/favorite_button.dart';

class DetailPage extends ConsumerWidget {
  final String mealId;
  final String mealName;

  const DetailPage({
    super.key,
    required this.mealId,
    required this.mealName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(mealDetailProvider(mealId));

    return Scaffold(
      appBar: AppBar(
        title: Text(mealName, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/'),
        ),
        actions: [
          FavoriteButton(
            mealId: mealId,
            meal: Meal(
              id: mealId,
              name: mealName,
              thumbnail: detailAsync.valueOrNull?.thumbnail ?? '',
            ),
          ),
        ],
      ),
      body: detailAsync.when(
        data: (detail) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  detail.thumbnail,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(
                    height: 240,
                    child: Center(child: Icon(Icons.broken_image, size: 64)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.category, size: 16),
                    label: Text(detail.category),
                  ),
                  Chip(
                    avatar: const Icon(Icons.public, size: 16),
                    label: Text(detail.area),
                  ),
                ],
              ),
              if (detail.tags != null && detail.tags!.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: detail.tags!
                      .split(',')
                      .map((t) => t.trim())
                      .where((t) => t.isNotEmpty)
                      .map((t) => Chip(label: Text(t)))
                      .toList(),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                'Ingredientes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ...detail.ingredientList.map(
                (ing) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8),
                      const SizedBox(width: 10),
                      Expanded(child: Text(ing)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Modo de Preparo',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(detail.instructions),
              if (detail.youtube != null && detail.youtube!.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('Ver no YouTube'),
                    onPressed: () {},
                  ),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 56, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar detalhes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
