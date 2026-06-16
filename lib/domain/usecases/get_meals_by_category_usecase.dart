import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMealsByCategoryUseCase {
  final MealRepository repository;
  const GetMealsByCategoryUseCase(this.repository);

  Future<List<Meal>> call(String category) =>
      repository.getMealsByCategory(category);
}
