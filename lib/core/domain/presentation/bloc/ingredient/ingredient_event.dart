import 'package:equatable/equatable.dart';

abstract class IngredientEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadIngredients extends IngredientEvent {}