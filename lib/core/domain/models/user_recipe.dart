import 'package:recipes/core/domain/models/ingredient_model.dart';

class UserRecipe
{
  final String title;
  final String image;
  final String imageExtension;
  final String description;
  final String category;
  final int readyInMinutes;
  final List<Ingredient> extendedIngredients;
  final List<String> steps;
  final bool isPublish;

  UserRecipe(this.title, this.image, this.imageExtension, this.description,
      this.category, this.readyInMinutes, this.extendedIngredients,
      this.steps, this.isPublish);
}