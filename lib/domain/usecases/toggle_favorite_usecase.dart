import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class ToggleFavoriteUseCase {
  final MealRepository repository;
  const ToggleFavoriteUseCase(this.repository);

  Future<void> call(Meal meal) => repository.toggleFavorite(meal);
}
