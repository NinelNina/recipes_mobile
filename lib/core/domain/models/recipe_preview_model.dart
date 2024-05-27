class RecipePreview
{
  final String id;
  final String title;
  final String image;
  final bool isUserRecipe;
  final bool isFavouriteRecipe;

  RecipePreview({required this.id, required this.title, required this.image,
    required this.isUserRecipe, required this.isFavouriteRecipe});
}