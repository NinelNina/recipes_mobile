import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/core/domain/models/diet_model.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_bloc.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_event.dart';
import 'package:recipes/core/domain/presentation/bloc/recipe/recipe_info/recipe_info_state.dart';
import 'package:recipes/core/domain/services/recipe_info_service.dart';

import 'widgets/categories_screen.dart';

class DietsCategories extends StatelessWidget {
  const DietsCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeInfoBloc(recipeInfoService: RecipeInfoService())..add(FetchDiets()),
      child: BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
        builder: (context, state) {
          if (state is RecipeInfoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RecipeInfoError) {
            return Center(child: Text('Failed to load diets: ${state.message}'));
          } else if (state is RecipeInfoLoaded<Diet>) {
            final categories = state.items.map((diet) => diet.title).toList();
            return Categories(title: 'Diets', categories: categories);
          } else {
            return Center(child: Text('No diets found'));
          }
        },
      ),
    );
  }
}
