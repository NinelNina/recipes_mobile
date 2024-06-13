import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

abstract class UserRecipeState extends Equatable {
  const UserRecipeState();

  @override
  List<Object> get props => [];
}

class UserRecipeInitial extends UserRecipeState {}

class UserRecipeLoading extends UserRecipeState {}

class UserRecipeLoaded extends UserRecipeState {
  final List<RecipePreview> recipes;

  const UserRecipeLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class UserRecipeError extends UserRecipeState {
  final String message;

  const UserRecipeError(this.message);

  @override
  List<Object> get props => [message];
}

class UserRecipeCreated extends UserRecipeState {}
