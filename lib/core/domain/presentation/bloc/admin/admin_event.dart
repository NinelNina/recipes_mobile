import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStatistic extends AdminEvent {}

class FetchRecipesToCheck extends AdminEvent {
  final int? page;
  final int? number;

  FetchRecipesToCheck({this.page, this.number});

  @override
  List<Object> get props => [page ?? 0, number ?? 10];
}

class CheckRecipe extends AdminEvent {
  final int recipeId;
  final bool isApproved;

  CheckRecipe({required this.recipeId, required this.isApproved});

  @override
  List<Object> get props => [recipeId, isApproved];
}
