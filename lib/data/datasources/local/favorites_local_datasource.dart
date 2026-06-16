import 'package:sqflite/sqflite.dart' hide DatabaseException;
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../models/meal_model.dart';
import 'database_helper.dart';

abstract class FavoritesLocalDataSource {
  Future<List<MealModel>> getFavorites();
  Future<void> insertFavorite(MealModel meal);
  Future<void> deleteFavorite(String id);
  Future<bool> isFavorite(String id);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  @override
  Future<List<MealModel>> getFavorites() async {
    try {
      final db = await DatabaseHelper.database;
      final maps = await db.query(AppConstants.favoritesTable);
      return maps.map(MealModel.fromDbMap).toList();
    } catch (e) {
      throw DatabaseException('Erro ao buscar favoritos: $e');
    }
  }

  @override
  Future<void> insertFavorite(MealModel meal) async {
    try {
      final db = await DatabaseHelper.database;
      await db.insert(
        AppConstants.favoritesTable,
        meal.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw DatabaseException('Erro ao inserir favorito: $e');
    }
  }

  @override
  Future<void> deleteFavorite(String id) async {
    try {
      final db = await DatabaseHelper.database;
      await db.delete(
        AppConstants.favoritesTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw DatabaseException('Erro ao remover favorito: $e');
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    try {
      final db = await DatabaseHelper.database;
      final result = await db.query(
        AppConstants.favoritesTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      return result.isNotEmpty;
    } catch (e) {
      throw DatabaseException('Erro ao verificar favorito: $e');
    }
  }
}
