import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

class RecipeSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecipeSearchInitial extends RecipeSearchState {}

class RecipeSearchLoaded extends RecipeSearchState {
  final List<RecipePreview> recipes;
  final int page;

  RecipeSearchLoaded(this.recipes, this.page);

  @override
  List<Object?> get props => [recipes, page];
}

class RecipeSearchError extends RecipeSearchState {
  final String message;

  RecipeSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
