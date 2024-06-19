import 'package:equatable/equatable.dart';

abstract class RecipeSearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRecipes extends RecipeSearchEvent {
  final String? query;
  final bool isUserRecipe;
  final String? type;
  final String? diet;
  final int? page;
  final int? number;

  FetchRecipes({this.query, required this.isUserRecipe, this.type, this.diet, this.page, this.number});

  @override
  List<Object?> get props => [query, isUserRecipe, type, diet, page, number];
}