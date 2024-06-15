import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/ingredient_model.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/services/token_service.dart';

class UserRecipeService {
  final Dio dio = Dio();
  TokenService _tokenService = TokenService();

  Future<List<RecipePreview>> getUserRecipes() async {
    try {
      final token = await _tokenService.getToken();
      final response = await dio.get('$apiRoot/v1/userRecipes/',
          options: Options(
            headers: {'token': token, 'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['results'];
        List<RecipePreview> recipes = [];
        if (body.isNotEmpty) {
          recipes =
              body.map((dynamic item) => RecipePreview.fromJson(item)).toList();
          print(recipes.toString());
        }
        return recipes;
      } else {
        throw Exception('Failed to load user recipes');
      }
    }
    on DioException catch (e) {
      throw Exception('Error fetching user recipes: ${e.message}');
    }
  }

  Future<void> createUserRecipe({
    required String title,
    required String? image,
    required String? imageExtension,
    required String description,
    required String category,
    required int readyInMinutes,
    required List<Ingredient> extendedIngredients,
    required List<String> steps,
    required bool isPublish,
  }) async {
    try {
      final token = await _tokenService.getToken();
      final response = await dio.post(
        '$apiRoot/v1/userRecipes/new',
        data: jsonEncode({
          'title': title,
          'image': image,
          'imageExtension': imageExtension,
          'description': description,
          'category': category,
          'readyInMinutes': readyInMinutes,
          'extendedIngredients': extendedIngredients.map((ingredient) => ingredient.toJson()).toList(),
          'steps': steps,
          'isPublish': isPublish,
        }),
        options: Options(
          headers: {'token': token, 'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create user recipe');
      }
    } on DioException catch (e) {
      throw Exception('Error creating user recipe: ${e.message}');
    }
  }
}
