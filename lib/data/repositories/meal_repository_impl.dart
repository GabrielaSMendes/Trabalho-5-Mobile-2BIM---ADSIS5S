import '../../domain/entities/category.dart';
import '../../domain/entities/meal.dart';
import '../../domain/entities/meal_detail.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/local/favorites_local_datasource.dart';
import '../datasources/remote/meal_remote_datasource.dart';
import '../models/meal_model.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;
  final FavoritesLocalDataSource localDataSource;

  const MealRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Category>> getCategories() async {
    final models = await remoteDataSource.getCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Meal>> getMealsByCategory(String category) async {
    final models = await remoteDataSource.getMealsByCategory(category);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<MealDetail> getMealDetail(String id) async {
    final model = await remoteDataSource.getMealDetail(id);
    return model.toEntity();
  }

  @override
  Future<void> toggleFavorite(Meal meal) async {
    final exists = await localDataSource.isFavorite(meal.id);
    if (exists) {
      await localDataSource.deleteFavorite(meal.id);
    } else {
      await localDataSource.insertFavorite(MealModel.fromEntity(meal));
    }
  }

  @override
  Future<List<Meal>> getFavorites() async {
    final models = await localDataSource.getFavorites();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<bool> isFavorite(String mealId) =>
      localDataSource.isFavorite(mealId);
}
