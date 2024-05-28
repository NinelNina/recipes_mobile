class RecipePreview
{
  final int id;
  final String title;
  final String? image;
  final bool isUserRecipe;
  final bool isFavouriteRecipe;

  RecipePreview({required this.id, required this.title, required this.image,
    required this.isUserRecipe, required this.isFavouriteRecipe});

  factory RecipePreview.fromJson(Map<String, dynamic> json) {
    return RecipePreview(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      isUserRecipe: json['isUserRecipe'],
      isFavouriteRecipe: json['isFavouriteRecipe'],
    );
  }
}