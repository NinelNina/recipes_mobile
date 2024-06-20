import 'package:equatable/equatable.dart';

abstract class RecipeInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchIngredients extends RecipeInfoEvent {}

class FetchDiets extends RecipeInfoEvent {}

class FetchMealTypes extends RecipeInfoEvent {}
