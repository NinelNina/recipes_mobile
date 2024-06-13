import 'package:equatable/equatable.dart';

abstract class UserRecipeEvent extends Equatable {
  const UserRecipeEvent();

  @override
  List<Object> get props => [];
}

class FetchUserRecipes extends UserRecipeEvent {}

class CreateUserRecipe extends UserRecipeEvent {
  final String title;
  final String image;
  final String imageExtension;
  final String description;
  final String category;
  final int readyInMinutes;
  final List<Map<String, dynamic>> extendedIngredients;
  final List<String> steps;
  final bool isPublish;

  const CreateUserRecipe({
    required this.title,
    required this.image,
    required this.imageExtension,
    required this.description,
    required this.category,
    required this.readyInMinutes,
    required this.extendedIngredients,
    required this.steps,
    required this.isPublish,
  });

  @override
  List<Object> get props => [
    title,
    image,
    imageExtension,
    description,
    category,
    readyInMinutes,
    extendedIngredients,
    steps,
    isPublish,
  ];
}
