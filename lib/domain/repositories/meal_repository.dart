import '../entities/category.dart';
import '../entities/meal.dart';
import '../entities/meal_detail.dart';

abstract class MealRepository {
  Future<List<Category>> getCategories();
  Future<List<Meal>> getMealsByCategory(String category);
  Future<MealDetail> getMealDetail(String id);
  Future<void> toggleFavorite(Meal meal);
  Future<List<Meal>> getFavorites();
  Future<bool> isFavorite(String mealId);
}
