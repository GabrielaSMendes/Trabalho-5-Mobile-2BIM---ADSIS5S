import 'package:flutter_test/flutter_test.dart';
import 'package:projetofinalflutter/data/models/category_model.dart';

void main() {
  group('CategoryModel', () {
    const sampleJson = {
      'idCategory': '1',
      'strCategory': 'Beef',
      'strCategoryThumb': 'https://example.com/beef.jpg',
      'strCategoryDescription': 'Receitas com carne bovina',
    };

    test('fromJson cria o modelo com todos os campos', () {
      final model = CategoryModel.fromJson(sampleJson);

      expect(model.id, '1');
      expect(model.name, 'Beef');
      expect(model.thumbnail, 'https://example.com/beef.jpg');
      expect(model.description, 'Receitas com carne bovina');
    });

    test('toJson serializa de volta com as chaves corretas da API', () {
      final model = CategoryModel.fromJson(sampleJson);
      final json = model.toJson();

      expect(json['idCategory'], '1');
      expect(json['strCategory'], 'Beef');
      expect(json['strCategoryThumb'], 'https://example.com/beef.jpg');
      expect(json['strCategoryDescription'], 'Receitas com carne bovina');
    });

    test('toEntity converte para entidade Category com os mesmos dados', () {
      final model = CategoryModel.fromJson(sampleJson);
      final entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.name, model.name);
      expect(entity.thumbnail, model.thumbnail);
      expect(entity.description, model.description);
    });
  });
}
