import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/translations.dart';
import '../providers/providers.dart';
import '../widgets/meal_card.dart';

class MealsPage extends ConsumerWidget {
  final String category;

  const MealsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(mealsByCategoryProvider(category));

    return Scaffold(
      appBar: AppBar(
        // Nome traduzido na barra; URL continua usando o nome em inglês (chave da API)
        title: Text(CategoryTranslation.translate(category)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/'),
        ),
      ),
      body: mealsAsync.when(
        data: (meals) => meals.isEmpty
            ? const Center(child: Text('Nenhuma receita encontrada.'))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: meals.length,
                itemBuilder: (context, index) => MealCard(
                  meal: meals[index],
                  // push: mantém a pilha para que o botão Voltar retorne a esta tela
                  onTap: () => context.push(
                    '/detail/${meals[index].id}'
                    '?name=${Uri.encodeComponent(meals[index].name)}',
                  ),
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
                'Erro ao carregar receitas',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
                onPressed: () =>
                    ref.refresh(mealsByCategoryProvider(category)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
