class MealDetail {
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

  const MealDetail({
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

  List<String> get ingredientList {
    final result = <String>[];
    for (int i = 0; i < ingredients.length; i++) {
      final ingredient = ingredients[i].trim();
      final measure = i < measures.length ? measures[i].trim() : '';
      final combined = '$measure $ingredient'.trim();
      if (combined.isNotEmpty) result.add(combined);
    }
    return result;
  }
}
