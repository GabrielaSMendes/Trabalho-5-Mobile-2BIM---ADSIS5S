import 'package:dio/dio.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../models/category_model.dart';
import '../../models/meal_detail_model.dart';
import '../../models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<MealModel>> getMealsByCategory(String category);
  Future<MealDetailModel> getMealDetail(String id);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final Dio dio;
  const MealRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get('/categories.php');
      final list = response.data['categories'] as List<dynamic>;
      return list
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erro ao buscar categorias');
    }
  }

  @override
  Future<List<MealModel>> getMealsByCategory(String category) async {
    try {
      final response =
          await dio.get('/filter.php', queryParameters: {'c': category});
      final list = response.data['meals'] as List<dynamic>? ?? [];
      return list
          .map((e) => MealModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erro ao buscar receitas');
    }
  }

  @override
  Future<MealDetailModel> getMealDetail(String id) async {
    try {
      final response =
          await dio.get('/lookup.php', queryParameters: {'i': id});
      final list = response.data['meals'] as List<dynamic>;
      return MealDetailModel.fromJson(list.first as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Erro ao buscar detalhes');
    }
  }
}
