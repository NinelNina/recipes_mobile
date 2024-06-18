import 'package:equatable/equatable.dart';

abstract class RecipeSearchEvent extends Equatable {
  const RecipeSearchEvent();

  @override
  List<Object> get props => [];
}

class FetchRecipes extends RecipeSearchEvent {
  final String? query;
  final bool isUserRecipe;
  final String? type;
  final String? diet;
  final int? page;
  final int? number;

  const FetchRecipes({
    required this.query,
    required this.isUserRecipe,
    required this.type,
    required this.diet,
    required this.page,
    required this.number,
  });

  @override
  List<Object> get props => [query!, isUserRecipe, type!, diet!, page!, number!];
}
