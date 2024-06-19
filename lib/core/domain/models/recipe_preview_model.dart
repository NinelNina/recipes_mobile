class RecipePreview
{
  final int id;
  final String title;
  final String? image;
  final bool isUserRecipe;
  final bool isFavouriteRecipe;

  RecipePreview({required this.id, required this.title, required this.image,
    required this.isUserRecipe, required this.isFavouriteRecipe});

  RecipePreview copyWith({
    int? id,
    String? title,
    String? image,
    bool? isFavouriteRecipe,
    bool? isUserRecipe,
  }) {
    return RecipePreview(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      isFavouriteRecipe: isFavouriteRecipe ?? this.isFavouriteRecipe,
      isUserRecipe: isUserRecipe ?? this.isUserRecipe,
    );
  }

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