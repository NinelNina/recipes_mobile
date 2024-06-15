abstract class RecipeEvent {}

class FetchRecipe extends RecipeEvent {
  final int id;
  final bool isUserRecipe;
  FetchRecipe(this.id, this.isUserRecipe);
}