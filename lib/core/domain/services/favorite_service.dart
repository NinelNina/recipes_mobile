import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/services/user_service.dart';

class FavoriteService{
  final Dio dio = Dio();
  UserService _tokenService = UserService();

  Future<void> addRecipeToFavorite(int recipeId, bool isUserRecipe) async {
    try {
      final token = await _tokenService.getToken();
      final response = await dio.post(
        '$apiRoot/v1/favoriteRecipes/$recipeId',
        queryParameters: { 'isUserRecipe': isUserRecipe },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'token': token,
          },
        )
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to add recipe to favorites');
      }
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<void> deleteRecipeFromFavorite(int recipeId, bool isUserRecipe) async {
    try {
      final token = await _tokenService.getToken();
      final response = await dio.delete(
          '$apiRoot/v1/favoriteRecipes/$recipeId',
          queryParameters: { 'isUserRecipe': isUserRecipe },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'token': token,
            },
          )
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete recipe from favorites');
      }
    } on DioException catch (e) {
      throw e;
    }
  }

  Future<List<RecipePreview>> getFavoriteRecipe(
      int? page,
      {int? number = 10}) async {
    try {
      var token = await _tokenService.getToken();
      final response = await dio.get(
          '$apiRoot/v1/favoriteRecipes/',
          queryParameters: {
            'page': page,
            'number': number },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'token': token,
            },
          )
      );

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['results'];
        List<RecipePreview> recipes = body.map((dynamic item) => RecipePreview.fromJson(item)).toList();
        return recipes;
      } else {
        throw Exception('Failed to load favorite recipes');
      }
    } on DioException catch (e) {
      throw e;
    }
  }
}