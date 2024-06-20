import 'package:recipes/core/domain/models/recipe_preview_model.dart';

abstract class RandomRecipeState {}

class RecipeInitial extends RandomRecipeState {}

class RecipeLoading extends RandomRecipeState {}

class RecipeLoaded extends RandomRecipeState {
  final RecipePreview recipe;

  RecipeLoaded(this.recipe);
}

class RecipeError extends RandomRecipeState {
  final String message;

  RecipeError(this.message);
}
