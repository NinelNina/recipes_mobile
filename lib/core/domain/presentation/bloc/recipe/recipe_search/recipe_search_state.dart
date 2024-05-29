import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

abstract class RecipeSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecipeSearchInitial extends RecipeSearchState {}

class RecipeSearchLoading extends RecipeSearchState {}

class RecipeSearchLoaded extends RecipeSearchState {
  final List<RecipePreview> recipes;

  RecipeSearchLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class RecipeSearchError extends RecipeSearchState {
  final String message;

  RecipeSearchError(this.message);

  @override
  List<Object?> get props => [message];
}