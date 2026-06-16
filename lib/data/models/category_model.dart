import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: 'idCategory')
  final String id;

  @JsonKey(name: 'strCategory')
  final String name;

  @JsonKey(name: 'strCategoryThumb')
  final String thumbnail;

  @JsonKey(name: 'strCategoryDescription')
  final String description;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  Category toEntity() => Category(
        id: id,
        name: name,
        thumbnail: thumbnail,
        description: description,
      );
}
