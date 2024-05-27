import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/models/recipe_model.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';

class RecipeService {
  final Dio dio = Dio();

  Future<RecipePreview> fetchRandomRecipePreview() async {
    try {
      final response = await dio.get('$apiRoot/v1/recipes/random');

      if (response.statusCode == 200) {
        return RecipePreview.fromJson(response.data);
      } else {
        throw Exception('Failed to load random recipe');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching random recipe: ${e.message}');
    }
  }

  Future<Recipe> fetchRecipe(int id) async {
    try {
      final response = await dio.get('$apiRoot/v1/recipes/$id',
          queryParameters: {'isUserRecipe': false});
      if (response.statusCode == 200) {
        final data = response.data;
        return Recipe(
          id: data['id'],
          title: data['title'],
          image: data['image'],
          description: data['description'],
          readyInMinutes: data['readyInMinutes'],
          extendedIngredients: (data['extendedIngredients'] as List)
              .map((i) => Ingredient.fromJson(i))
              .toList(),
          steps: List<String>.from(data['steps']),
          isUserRecipe: data['isUserRecipe'],
          isFavouriteRecipe: data['isFavouriteRecipe'],
        );
      } else {
        throw Exception('Failed to load recipe');
      }
    } catch (e) {
      throw Exception('Error fetching recipe: $e');
    }
  }
}
