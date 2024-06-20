import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/models/diet_model.dart';
import 'package:recipes/core/domain/models/meal_type_model.dart';

abstract class RecipeInfoState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeInfoInitial extends RecipeInfoState {}

class RecipeInfoLoading extends RecipeInfoState {}

class RecipeInfoLoaded<T> extends RecipeInfoState {
  final List<T> items;

  RecipeInfoLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class RecipeInfoError extends RecipeInfoState {
  final String message;

  RecipeInfoError(this.message);

  @override
  List<Object> get props => [message];
}
