import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/models/recipe_model.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/services/user_service.dart';

class RecipeService {
  final Dio dio = Dio();
  UserService _userService = UserService();

  Future<RecipePreview> fetchRandomRecipePreview() async {
    try {
      var token = await _userService.getToken();
      final response = await dio.get('$apiRoot/v1/recipes/random',
          queryParameters: {'isUserRecipe': false},
          options: Options(headers: {'token': token}));

      if (response.statusCode == 200) {
        return RecipePreview.fromJson(response.data);
      } else {
        throw Exception('Failed to load random recipe');
      }
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<Recipe> fetchRecipe(int id, bool isUserRecipe) async {
    var token = await _userService.getToken();
    try {
      final response = await dio.get('$apiRoot/v1/recipes/$id',
          queryParameters: {'isUserRecipe': isUserRecipe},
          options: Options(headers: {'token': token}));

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
          type: data['type'],
        );
      } else {
        throw Exception('Failed to load recipe');
      }
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<List<RecipePreview>> fetchComplexSearch(
      String? query,
      bool isUserRecipe,
      String? type,
      String? diet,
      int? page,
      {int? number = 10}) async {
    try {
      var token = await _userService.getToken();
      final response = await dio.get('$apiRoot/v1/recipes/complexSearch',
          queryParameters: {
            'query': query,
            'isUserRecipes': isUserRecipe,
            'type': type,
            'diet': diet,
            'page': page,
            'number': number
          },
          options: Options(headers: {'token': token}));

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['results'];
        List<RecipePreview> recipes = body.map((dynamic item) => RecipePreview.fromJson(item)).toList();
        return recipes;
      } else {
        throw Exception('Failed to load recipes');
      }
    } on DioException catch (e) {
      throw e;
    }
  }
}
