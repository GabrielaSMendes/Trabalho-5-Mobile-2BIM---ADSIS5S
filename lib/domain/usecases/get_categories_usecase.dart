import '../entities/category.dart';
import '../repositories/meal_repository.dart';

class GetCategoriesUseCase {
  final MealRepository repository;
  const GetCategoriesUseCase(this.repository);

  Future<List<Category>> call() => repository.getCategories();
}
