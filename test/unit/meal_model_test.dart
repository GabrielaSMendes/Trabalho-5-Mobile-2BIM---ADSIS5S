import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/data/models/meal_model.dart';
import 'package:projetofinalflutter/domain/entities/meal.dart';

void main() {
  group('MealModel', () {
    const sampleJson = {
      'idMeal': '52772',
      'strMeal': 'Beef and Mustard Pie',
      'strMealThumb': 'https://example.com/pie.jpg',
    };

    test('fromJson cria o modelo corretamente', () {
      final model = MealModel.fromJson(sampleJson);

      expect(model.id, '52772');
      expect(model.name, 'Beef and Mustard Pie');
      expect(model.thumbnail, 'https://example.com/pie.jpg');
    });

    test('toEntity converte para entidade Meal', () {
      final model = MealModel.fromJson(sampleJson);
      final entity = model.toEntity();

      expect(entity.id, '52772');
      expect(entity.name, 'Beef and Mustard Pie');
      expect(entity.thumbnail, 'https://example.com/pie.jpg');
    });

    test('fromEntity cria MealModel a partir de uma entidade', () {
      const entity = Meal(id: '99', name: 'Test Meal', thumbnail: 'http://img.com');
      final model = MealModel.fromEntity(entity);

      expect(model.id, '99');
      expect(model.name, 'Test Meal');
      expect(model.thumbnail, 'http://img.com');
    });

    test('toDbMap gera mapa com as chaves corretas para SQLite', () {
      final model = MealModel.fromJson(sampleJson);
      final map = model.toDbMap();

      expect(map.containsKey('id'), isTrue);
      expect(map.containsKey('name'), isTrue);
      expect(map.containsKey('thumbnail'), isTrue);
      expect(map['id'], '52772');
    });

    test('fromDbMap reconstrói o modelo a partir do mapa do SQLite', () {
      const dbMap = {
        'id': '42',
        'name': 'Spaghetti',
        'thumbnail': 'http://spaghetti.jpg',
      };
      final model = MealModel.fromDbMap(dbMap);

      expect(model.id, '42');
      expect(model.name, 'Spaghetti');
      expect(model.thumbnail, 'http://spaghetti.jpg');
    });
  });
}
