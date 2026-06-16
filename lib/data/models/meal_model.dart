import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/meal.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel {
  @JsonKey(name: 'idMeal')
  final String id;

  @JsonKey(name: 'strMeal')
  final String name;

  @JsonKey(name: 'strMealThumb')
  final String thumbnail;

  const MealModel({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);

  Meal toEntity() => Meal(id: id, name: name, thumbnail: thumbnail);

  factory MealModel.fromEntity(Meal meal) =>
      MealModel(id: meal.id, name: meal.name, thumbnail: meal.thumbnail);

  Map<String, dynamic> toDbMap() =>
      {'id': id, 'name': name, 'thumbnail': thumbnail};

  factory MealModel.fromDbMap(Map<String, dynamic> map) => MealModel(
        id: map['id'] as String,
        name: map['name'] as String,
        thumbnail: map['thumbnail'] as String,
      );
}
