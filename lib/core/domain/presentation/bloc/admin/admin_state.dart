import 'package:equatable/equatable.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/models/statistic_model.dart';

abstract class AdminState extends Equatable {
  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class StatisticLoaded extends AdminState {
  final Statistic statistic;

  StatisticLoaded({required this.statistic});

  @override
  List<Object> get props => [statistic];
}

class RecipesLoaded extends AdminState {
  final List<RecipePreview> recipes;

  RecipesLoaded({required this.recipes});

  @override
  List<Object> get props => [recipes];
}

class RecipeChecked extends AdminState {}

class AdminError extends AdminState {
  final String message;

  AdminError({required this.message});

  @override
  List<Object> get props => [message];
}

class RecipeApproved extends RecipeChecked {}
class RecipeRejected extends RecipeChecked {}