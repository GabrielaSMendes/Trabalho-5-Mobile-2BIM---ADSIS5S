import '../../domain/entities/meal_detail.dart';

// Parsing manual: a API TheMealDB retorna até 20 ingredientes como campos avulsos
// (strIngredient1..20 / strMeasure1..20), então json_serializable não ajuda aqui.
class MealDetailModel {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String? tags;
  final String? youtube;
  final List<String> ingredients;
  final List<String> measures;

  const MealDetailModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    this.tags,
    this.youtube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetailModel.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    final measures = <String>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = (json['strIngredient$i'] as String? ?? '').trim();
      final measure = (json['strMeasure$i'] as String? ?? '').trim();
      if (ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure);
      }
    }

    // Usa instruções em PT quando disponíveis; inglês como fallback.
    final instructionsPt = (json['strInstructionsPT'] as String? ?? '').trim();
    final instructionsEn = (json['strInstructions'] as String? ?? '').trim();

    return MealDetailModel(
      id: json['idMeal'] as String,
      name: json['strMeal'] as String,
      category: json['strCategory'] as String,
      area: json['strArea'] as String,
      instructions: instructionsPt.isNotEmpty ? instructionsPt : instructionsEn,
      thumbnail: json['strMealThumb'] as String,
      tags: json['strTags'] as String?,
      youtube: json['strYoutube'] as String?,
      ingredients: ingredients,
      measures: measures,
    );
  }

  MealDetail toEntity() => MealDetail(
        id: id,
        name: name,
        category: category,
        area: area,
        instructions: instructions,
        thumbnail: thumbnail,
        tags: tags,
        youtube: youtube,
        ingredients: ingredients,
        measures: measures,
      );
}
