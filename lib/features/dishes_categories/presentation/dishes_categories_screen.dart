import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/models/meal_type_model.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_state.dart';
import 'package:recipes/core/domain/services/recipe_info_service.dart';

import 'widgets/categories_screen.dart';

class DishesCategories extends StatelessWidget {
  const DishesCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeInfoBloc(recipeInfoService: RecipeInfoService())..add(FetchMealTypes()),
      child: BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
        builder: (context, state) {
          if (state is RecipeInfoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecipeInfoError) {
            return Center(child: Text('Failed to load meal types: ${state.message}'));
          } else if (state is RecipeInfoLoaded<MealType>) {
            final categories = state.items.map((mealType) => mealType.title).toList();
            return Categories(title: 'Categories', categories: categories);
          } else {
            return Center(child: Text('No categories found'));
          }
        },
      ),
    );
  }
}
