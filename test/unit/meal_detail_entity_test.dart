import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/domain/entities/meal_detail.dart';

void main() {
  group('MealDetail.ingredientList', () {
    MealDetail buildDetail({
      required List<String> ingredients,
      required List<String> measures,
    }) {
      return MealDetail(
        id: '1',
        name: 'Test',
        category: 'Cat',
        area: 'Area',
        instructions: 'Cook.',
        thumbnail: 'http://img.jpg',
        ingredients: ingredients,
        measures: measures,
      );
    }

    test('combina medida e ingrediente em uma string só', () {
      final detail = buildDetail(
        ingredients: ['Salt', 'Pepper'],
        measures: ['1 tsp', '1/2 tsp'],
      );

      final list = detail.ingredientList;
      expect(list[0], '1 tsp Salt');
      expect(list[1], '1/2 tsp Pepper');
    });

    test('remove entradas com ingrediente vazio', () {
      final detail = buildDetail(
        ingredients: ['Salt', '', 'Garlic'],
        measures: ['1 tsp', '', '2 cloves'],
      );

      final list = detail.ingredientList;
      expect(list.length, 2);
      expect(list[0], '1 tsp Salt');
      expect(list[1], '2 cloves Garlic');
    });

    test('funciona quando measure está em branco mas ingrediente não', () {
      final detail = buildDetail(
        ingredients: ['Water'],
        measures: [''],
      );

      final list = detail.ingredientList;
      expect(list.length, 1);
      expect(list.first, 'Water');
    });

    test('retorna lista vazia quando não há ingredientes', () {
      final detail = buildDetail(ingredients: [], measures: []);
      expect(detail.ingredientList, isEmpty);
    });
  });
}
