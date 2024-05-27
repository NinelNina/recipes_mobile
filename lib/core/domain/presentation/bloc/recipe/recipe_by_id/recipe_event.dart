abstract class RecipeEvent {}

class FetchRecipe extends RecipeEvent {
  final int id;
  FetchRecipe(this.id);
}