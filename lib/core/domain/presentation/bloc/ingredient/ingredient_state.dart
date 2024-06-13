import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/ingredient_with_units_model.dart';

abstract class IngredientState extends Equatable {
  @override
  List<Object> get props => [];
}

class IngredientInitial extends IngredientState {}

class IngredientLoading extends IngredientState {}

class IngredientLoaded extends IngredientState {
  final List<IngredientWithUnits> ingredients;

  IngredientLoaded(this.ingredients);

  @override
  List<Object> get props => [ingredients];
}

class IngredientError extends IngredientState {
  final String message;

  IngredientError(this.message);

  @override
  List<Object> get props => [message];
}