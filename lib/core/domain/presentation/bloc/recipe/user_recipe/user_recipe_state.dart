import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

abstract class UserRecipeState extends Equatable {
  const UserRecipeState();

  @override
  List<Object> get props => [];
}

class UserRecipeInitial extends UserRecipeState {}

class UserRecipeLoading extends UserRecipeState {}

class UserRecipeEmpty extends UserRecipeState {}

class UserRecipeLoaded extends UserRecipeState {
  final List<RecipePreview> recipes;
  final int page;

  const UserRecipeLoaded(this.recipes, this.page);

  @override
  List<Object> get props => [recipes, page];
}

class UserRecipeError extends UserRecipeState {
  final String message;

  const UserRecipeError(this.message);

  @override
  List<Object> get props => [message];
}

class UserRecipeCreated extends UserRecipeState {}
