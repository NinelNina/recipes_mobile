import 'package:dio/dio.dart';
import 'package:recipes/core/api/api_root.dart';
import 'package:recipes/core/domain/models/diet_model.dart';
import 'package:recipes/core/domain/models/ingredient_with_units_model.dart';
import 'package:recipes/core/domain/models/meal_type_model.dart';

class RecipeInfoService {
  final Dio dio = Dio();

  Future<List<IngredientWithUnits>> getIngredients() async {
    try {
      final response = await dio.get('$apiRoot/v1/ingredients/');
      if (response.statusCode == 200) {
        List<IngredientWithUnits> ingredients = [];
        for (var ingredient in response.data['ingredients']) {
          List<String> unitsList = List<String>.from(ingredient['units'].map((unit) => unit.toString()));

          ingredients.add(IngredientWithUnits(
              title: ingredient['title'], units: unitsList));
        }
        return ingredients;
      } else {
        throw Exception('Failed to load ingredients');
      }
    } on DioException catch (e) {
      throw Exception('Error getting ingredients: ${e.message}');
    }
  }

  Future<List<Diet>> getDiets() async {
    try {
      final response = await dio.get('$apiRoot/v1/diets/');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['diets'];
        List<Diet> diets = body.map((dynamic item) => Diet.fromJson(item)).toList();
        return diets;
      } else {
        throw Exception('Failed to load diets');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching diets: ${e.message}');
    }
  }

  Future<List<MealType>> getMealTypes() async {
    try {
      final response = await dio.get('$apiRoot/v1/mealTypes/');

      if (response.statusCode == 200) {
        List<dynamic> body = response.data['mealTypes'];
        List<MealType> mealTypes = body.map((dynamic item) => MealType.fromJson(item)).toList();
        print(mealTypes[0].title);
        return mealTypes;
      } else {
        throw Exception('Failed to load meal types');
      }
    } on DioException catch (e) {
      throw Exception('Error fetching meal types: ${e.message}');
    }
  }
}
