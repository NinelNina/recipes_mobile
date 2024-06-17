import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/recipe_preview_model.dart';
import 'package:recipes/core/domain/models/statistic_model.dart';
import 'package:recipes/core/domain/services/user_service.dart';

class AdminService {
  final Dio dio = Dio();
  UserService _userService = UserService();

  Future<Statistic> getStatistic() async {
    var token = await _userService.getToken();
    try {
      final response = await dio.get('$apiRoot/v1/admin/statistic',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ));
      if (response.statusCode == 200) {
        return Statistic(
            response.data['quantityUsers'],
            response.data['quantityUserRecipes'],
            response.data['popularDiet'],
            response.data['popularRecipe']);
      } else {
        throw Exception('Failed to load statistic');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching statistic: ${e.message}');
    }
  }

  Future<List<RecipePreview>> fetchRecipesToCheck(
      int? page,
      {int? number = 10}) async {
    var token = await _userService.getToken();
    try {
      final response = await dio.get('$apiRoot/v1/admin/recipesToCheck',
          queryParameters: {
            'page': page,
            'number': number
          },
          options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ));

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['results'];
        List<RecipePreview> recipes = body.map((dynamic item) => RecipePreview.fromJson(item)).toList();
        return recipes;
      } else {
        throw Exception('Failed to load recipes');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching recipes: ${e.message}');
    }
  }

  Future<void> checkRecipe(
      int recipeId,
      bool isApproved) async {
    var token = await _userService.getToken();
    try {
      final response = await dio.post('$apiRoot/v1/admin/recipesToCheck/$recipeId',
          queryParameters: {
            'isApproved': isApproved
          },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode != 200) {
        throw Exception('Failed to load recipes');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching recipes: ${e.message}');
    }
  }
}
