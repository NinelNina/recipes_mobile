import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteAdded extends FavoriteState {
  final int recipeId;
  final bool isFavorite;

  const FavoriteAdded({required this.recipeId, required this.isFavorite});

  @override
  List<Object?> get props => [recipeId, isFavorite];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<RecipePreview> recipes;

  const FavoriteLoaded({required this.recipes});

  @override
  List<Object?> get props => [recipes];
}

class FavoriteError extends FavoriteState {
  final String message;

  const FavoriteError({required this.message});

  @override
  List<Object?> get props => [message];
}
