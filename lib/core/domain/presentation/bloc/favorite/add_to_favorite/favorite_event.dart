import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class AddRecipeToFavorite extends FavoriteEvent {
  final String recipeId;
  final bool isUserRecipe;

  const AddRecipeToFavorite({required this.recipeId, required this.isUserRecipe});

  @override
  List<Object?> get props => [recipeId, isUserRecipe];
}

class DeleteRecipeFromFavorite extends FavoriteEvent {
  final String recipeId;
  final bool isUserRecipe;

  const DeleteRecipeFromFavorite({required this.recipeId, required this.isUserRecipe});

  @override
  List<Object?> get props => [recipeId, isUserRecipe];
}

class GetFavoriteRecipes extends FavoriteEvent {
  final int? page;
  final int? number;

  const GetFavoriteRecipes({this.page, this.number = 10});

  @override
  List<Object?> get props => [page, number];
}
