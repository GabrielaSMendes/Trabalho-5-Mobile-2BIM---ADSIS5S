import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/dio_client.dart';
import '../../data/datasources/local/favorites_local_datasource.dart';
import '../../data/datasources/remote/meal_remote_datasource.dart';
import '../../data/repositories/meal_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/meal.dart';
import '../../domain/entities/meal_detail.dart';
import '../../domain/repositories/meal_repository.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/get_meal_detail_usecase.dart';
import '../../domain/usecases/get_meals_by_category_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

// ---------- Infraestrutura ----------

final dioProvider = Provider<Dio>((_) => DioClient.create());

final remoteDataSourceProvider = Provider<MealRemoteDataSource>(
    (ref) => MealRemoteDataSourceImpl(ref.watch(dioProvider)));

final localDataSourceProvider = Provider<FavoritesLocalDataSource>(
    (_) => FavoritesLocalDataSourceImpl());

final repositoryProvider = Provider<MealRepository>(
  (ref) => MealRepositoryImpl(
    remoteDataSource: ref.watch(remoteDataSourceProvider),
    localDataSource: ref.watch(localDataSourceProvider),
  ),
);

// ---------- Use cases ----------

final getCategoriesUseCaseProvider = Provider(
    (ref) => GetCategoriesUseCase(ref.watch(repositoryProvider)));

final getMealsByCategoryUseCaseProvider = Provider(
    (ref) => GetMealsByCategoryUseCase(ref.watch(repositoryProvider)));

final getMealDetailUseCaseProvider = Provider(
    (ref) => GetMealDetailUseCase(ref.watch(repositoryProvider)));

final toggleFavoriteUseCaseProvider = Provider(
    (ref) => ToggleFavoriteUseCase(ref.watch(repositoryProvider)));

final getFavoritesUseCaseProvider = Provider(
    (ref) => GetFavoritesUseCase(ref.watch(repositoryProvider)));

// ---------- Dados ----------

final categoriesProvider = FutureProvider<List<Category>>(
    (ref) => ref.watch(getCategoriesUseCaseProvider).call());

final mealsByCategoryProvider =
    FutureProvider.family<List<Meal>, String>((ref, category) =>
        ref.watch(getMealsByCategoryUseCaseProvider).call(category));

final mealDetailProvider =
    FutureProvider.family<MealDetail, String>((ref, id) =>
        ref.watch(getMealDetailUseCaseProvider).call(id));

final favoritesProvider = FutureProvider<List<Meal>>(
    (ref) => ref.watch(getFavoritesUseCaseProvider).call());

final isFavoriteProvider =
    FutureProvider.family<bool, String>((ref, id) =>
        ref.watch(repositoryProvider).isFavorite(id));
