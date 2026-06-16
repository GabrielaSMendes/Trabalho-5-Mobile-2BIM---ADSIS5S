import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetFavoritesUseCase {
  final MealRepository repository;
  const GetFavoritesUseCase(this.repository);

  Future<List<Meal>> call() => repository.getFavorites();
}
