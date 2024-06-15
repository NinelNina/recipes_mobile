import 'package:recipes/core/domain/models/ingredient_model.dart';

class Recipe
{
  final int id;
  final String title;
  final String image;
  final String? description;
  final int readyInMinutes;
  final List<Ingredient> extendedIngredients;
  final List<String>? steps;
  final bool isUserRecipe;
  final bool isFavouriteRecipe;
  //TODO: добавить type

  Recipe({required this.id, required this.title, required this.image,
    required this.description, required this.readyInMinutes,
    required this.extendedIngredients, required this.steps,
    required this.isUserRecipe, required this.isFavouriteRecipe});
}