import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/ingredient_with_units_model.dart';

class IngredientService {
  final Dio dio = Dio();

  Future<List<IngredientWithUnits>> getIngredients() async {
    try {
      final response = await dio.get('$apiRoot/v1/ingredients/');
      if (response.statusCode == 200) {
        List<IngredientWithUnits> ingredients = [];
        for (var ingredient in response.data){
          ingredients.add(IngredientWithUnits.fromJson(ingredient));
        }
        return ingredients;
      } else {
        throw Exception('Failed to load ingredients');
      }
    } on DioException catch (e) {
      throw Exception('Error getting ingredients: ${e.message}');
    }
  }
}