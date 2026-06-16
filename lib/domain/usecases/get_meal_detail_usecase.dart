import '../entities/meal_detail.dart';
import '../repositories/meal_repository.dart';

class GetMealDetailUseCase {
  final MealRepository repository;
  const GetMealDetailUseCase(this.repository);

  Future<MealDetail> call(String id) => repository.getMealDetail(id);
}
