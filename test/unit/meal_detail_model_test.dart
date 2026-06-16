import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/data/models/meal_detail_model.dart';

void main() {
  group('MealDetailModel.fromJson', () {
    Map<String, dynamic> buildJson({Map<String, String?> extras = const {}}) {
      final base = <String, dynamic>{
        'idMeal': '52772',
        'strMeal': 'Beef and Mustard Pie',
        'strCategory': 'Beef',
        'strArea': 'British',
        'strInstructions': 'Mix and bake.',
        'strMealThumb': 'https://example.com/pie.jpg',
        'strTags': 'Pie,Baking',
        'strYoutube': 'https://youtube.com/watch?v=abc',
      };
      // preenche ingredientes/medidas em branco por padrão
      for (int i = 1; i <= 20; i++) {
        base['strIngredient$i'] = null;
        base['strMeasure$i'] = null;
      }
      base.addAll(extras);
      return base;
    }

    test('analisa campos básicos corretamente', () {
      final json = buildJson();
      final model = MealDetailModel.fromJson(json);

      expect(model.id, '52772');
      expect(model.name, 'Beef and Mustard Pie');
      expect(model.category, 'Beef');
      expect(model.area, 'British');
      expect(model.tags, 'Pie,Baking');
      expect(model.youtube, 'https://youtube.com/watch?v=abc');
    });

    test('filtra ingredientes vazios e mantém os preenchidos', () {
      final json = buildJson(extras: {
        'strIngredient1': 'Beef',
        'strMeasure1': '500g',
        'strIngredient2': 'Mustard',
        'strMeasure2': '2 tbsp',
        'strIngredient3': '',   // deve ser ignorado
        'strMeasure3': '',
      });
      final model = MealDetailModel.fromJson(json);

      expect(model.ingredients.length, 2);
      expect(model.ingredients[0], 'Beef');
      expect(model.ingredients[1], 'Mustard');
      expect(model.measures[0], '500g');
    });

    test('toEntity converte para MealDetail com os dados corretos', () {
      final json = buildJson(extras: {
        'strIngredient1': 'Salt',
        'strMeasure1': '1 tsp',
      });
      final model = MealDetailModel.fromJson(json);
      final entity = model.toEntity();

      expect(entity.id, '52772');
      expect(entity.ingredients.length, 1);
      expect(entity.ingredients.first, 'Salt');
    });
  });
}
